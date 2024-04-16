using FluentValidation;
using HappyPaws.Api.Auth.AuthService;
using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.Config;
using HappyPaws.Application.Mappings;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Common.Services.CryptoService;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Common.Services.EnumsService;
using HappyPaws.Core.Dtos;
using HappyPaws.Core.Dtos.PetType;
using HappyPaws.Infrastructure;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Localization;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Globalization;
using System.Text;

namespace HappyPaws.Api
{
    public static class Registry
    {
        public static T BindConfig<T>(this WebApplicationBuilder builder, string key) where T : class
        {
            var section = builder.Configuration.GetSection(key);
            builder.Services.Configure<T>(section);
            return section.Get<T>()!;
        }

        public static void AddMapper(this IServiceCollection services)
        {
            services.AddAutoMapper(typeof(Program), typeof(BaseProfile));
        }
        public static IApplicationBuilder UseRequestValidationMiddlewares(this IApplicationBuilder app)
        {
            var dtoTypes = AppDomain.CurrentDomain.GetAssemblies()
            .SelectMany(assembly => assembly.GetTypes())
            .Where(type => type.IsClass && !type.IsAbstract && type.Name.EndsWith("Dto"));

            foreach (var dtoType in dtoTypes)
            {
                // Find validator for the DTO type
                var validatorType = AppDomain.CurrentDomain.GetAssemblies()
                    .SelectMany(assembly => assembly.GetTypes())
                    .FirstOrDefault(type =>
                        type.IsSubclassOf(typeof(AbstractValidator<>).MakeGenericType(dtoType)));

                if (validatorType != null)
                {
                    // Construct the middleware type and validator instance
                    var middlewareType = typeof(RequestValidationMiddleware<>).MakeGenericType(dtoType);
                    var validatorInstance = Activator.CreateInstance(validatorType);

                    // Register the middleware with the appropriate validator
                    app.UseMiddleware(middlewareType, validatorInstance);
                }
            }

            return app;
        }

        public static void UseMiddlewares(this IApplicationBuilder app)
        {
            //app.UseRequestValidationMiddlewares();
        }
        public static void AddDatabase(this IServiceCollection services, ConnectionStringConfig config)
        {
            services.AddDbContext<DatabaseContext>(options => options.UseSqlServer(config.Main));
        }
        public static void AddAuthenticationAndAuthorization(this IServiceCollection services, JwtTokenConfig jwtTokenConfig)
        {
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(o =>
            {
                o.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidIssuer = jwtTokenConfig.Issuer,
                    ValidAudience = jwtTokenConfig.Audience,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtTokenConfig.SecretKey)),
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = false,
                    ValidateIssuerSigningKey = true
                };
                o.Events = new JwtBearerEvents
                {
                    OnMessageReceived = context =>

                    {
                        var accessToken = context.Request.Query["access_token"];
                        if (!string.IsNullOrEmpty(accessToken))
                        {
                            context.Token = accessToken;
                        }
                        return Task.CompletedTask;
                    }
                };

            });
            services.AddAuthorization();
        }

        public static void AddSwagger(this IServiceCollection services)
        {
            services.AddEndpointsApiExplorer();
            services.AddSwaggerGen(setup =>
            {
                var jwtSecurityScheme = new OpenApiSecurityScheme
                {
                    BearerFormat = "JWT",
                    Name = "JWT Authentication",
                    In = ParameterLocation.Header,
                    Type = SecuritySchemeType.Http,
                    Scheme = JwtBearerDefaults.AuthenticationScheme,
                    Reference = new OpenApiReference
                    {
                        Id = JwtBearerDefaults.AuthenticationScheme,
                        Type = ReferenceType.SecurityScheme
                    }
                };

                setup.AddSecurityDefinition(jwtSecurityScheme.Reference.Id, jwtSecurityScheme);
                setup.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                    { jwtSecurityScheme, Array.Empty<string>() }
            });
            });

        }

        public static void AddOther(this IServiceCollection services)
        {
            services.AddSingleton<ICryptoService, CryptoService>();
            services.AddScoped<IAuthService, AuthService>();
            services.AddScoped<IEmailService, EmailService>();
            services.AddScoped<IEnumsService, EnumsService>();
            services.AddHttpContextAccessor().AddScoped<CurrentUser>().AddSingleton<ClaimsPrincipalAccessor>();


        }

    }
}
