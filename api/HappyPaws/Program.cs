using HappyPaws.Api;
using HappyPaws.Api.Config;
using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application;
using HappyPaws.Infrastructure;
using Microsoft.EntityFrameworkCore;
using System.Reflection.Emit;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);
var connectionStringConfig = builder.BindConfig<ConnectionStringConfig>("ConnectionStrings");
var jwtTokenConfig = builder.BindConfig<JwtTokenConfig>("JwtToken");

builder.Services.AddMapper();
builder.Services.AddValidators();
builder.Services.AddApplication();
builder.Services.AddInfrastructure();
builder.Services.AddOther();
builder.Services.AddDatabase(builder, connectionStringConfig);
builder.Services.AddAuthenticationAndAuthorization(jwtTokenConfig);
builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.Preserve;
    options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
    options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwagger();

var app = builder.Build();


if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


app.UseHttpsRedirection();
app.UseAuthorization();
app.UseAuthentication();
app.MapControllers();
app.MapHub<MessageHub>("/messageHub");
using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<DatabaseContext>();
    dataContext.Database.EnsureCreated();
    //dataContext.Database.Migrate();
}

app.Run();
