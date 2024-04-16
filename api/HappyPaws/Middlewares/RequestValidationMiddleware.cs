using FluentValidation;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using System;
using System.IO;
using System.Threading.Tasks;

public class RequestValidationMiddleware<TDto>
{
    private readonly RequestDelegate _next;
    private readonly AbstractValidator<TDto> _validator;

    public RequestValidationMiddleware(RequestDelegate next, AbstractValidator<TDto> validator)
    {
        _next = next;
        _validator = validator;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        if (context.Request.Method == "POST")
        {
            var dtoType = InferDtoTypeFromRequest(context.Request.Path);

            if (dtoType == null)
            {
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                await context.Response.WriteAsync("Unknown endpoint");
                return;
            }

            // Read request body
            using var reader = new StreamReader(context.Request.Body);
            var requestBody = await reader.ReadToEndAsync();

            // Deserialize request body based on the inferred DTO type
            var dto = JsonConvert.DeserializeObject(requestBody, dtoType);

            // Validate DTO
            await ValidateAsync((TDto)dto, context);

        }

        await _next(context);
    }
    private Type InferDtoTypeFromRequest(string path)
    {
        var segments = path.Split('/').Where(s => !string.IsNullOrEmpty(s)).ToList();
        if (segments.Count > 0)
        {
            // Get the last segment of the path
            var lastSegment = segments.Last().ToLowerInvariant();

            // Remove plural suffix if present (assuming pluralization convention)
            if (lastSegment.EndsWith("es"))
            {
                lastSegment = lastSegment.Substring(0, lastSegment.Length - 2);
            }
            else if (lastSegment.EndsWith("s"))
            {
                lastSegment = lastSegment.Substring(0, lastSegment.Length - 1);
            }

            // Construct DTO type name by appending "Dto"
            var dtoTypeName = $"{lastSegment}Dto";

            // Find the type by name
            var dtoType = AppDomain.CurrentDomain.GetAssemblies()
                .SelectMany(assembly => assembly.GetTypes())
                .FirstOrDefault(type =>
                    type.IsClass &&
                    type.Name.Equals(dtoTypeName, StringComparison.OrdinalIgnoreCase));

            return dtoType;
        }

        return null; // Unknown endpoint
    }


    protected async Task ValidateAsync(TDto dto, HttpContext context)
    {
        var validationResult = await _validator.ValidateAsync(dto);

        if (!validationResult.IsValid)
        {
            // If validation fails, set the appropriate status code and return
            context.Response.StatusCode = StatusCodes.Status403Forbidden;
            await context.Response.WriteAsync("Validation error: " + string.Join(", ", validationResult.Errors));
            return;
        }
    }
}
