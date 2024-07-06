using HappyPaws.Api.Auth.AuthService;
using HappyPaws.Api.Auth.CurrentUserClaims;
using HappyPaws.Api.Config;
using HappyPaws.Api.Hubs.MessageHub;
using HappyPaws.Application.Mappings;
using HappyPaws.Common.Services.AuthService;
using HappyPaws.Common.Services.CryptoService;
using HappyPaws.Common.Services.EmailService;
using HappyPaws.Common.Services.EnumsService;
using HappyPaws.Common.Services.RecommenderSystemService;
using HappyPaws.Infrastructure;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
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

        public static void AddDatabase(this IServiceCollection services, WebApplicationBuilder builder, ConnectionStringConfig config)
        {
            services.AddDbContext<DatabaseContext>(options =>
            {
                options.UseSqlServer(config.Main)
                .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()));
                if (builder.Environment.IsDevelopment())
                {
                    options.EnableSensitiveDataLogging();
                }
            });
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
                    ValidateIssuerSigningKey = true,
                    RoleClaimType = "Role",
                 
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
            services.AddAuthorization(options =>
            {
                options.AddPolicy("AllVerified", policy => policy.RequireClaim("Role", "User", "Admin", "Employee"));
                options.AddPolicy("VetsOnly", policy => policy.RequireClaim("EmployeePosition", "Veterinarian", "VeterinarianTechnician", "VeterinarianAssistant"));
                options.AddPolicy("ClinicPolicy", policy =>
                {
                    policy.RequireAssertion(context =>
                    {
                        return context.User.IsInRole("User") || context.User.IsInRole("Admin") ||
                         context.User.HasClaim("EmployeePosition", "Veterinarian") ||
                         context.User.HasClaim("EmployeePosition", "VeterinarianAssistant") ||
                         context.User.HasClaim("EmployeePosition", "VeterinarianTechnician");
                    });
                });
                options.AddPolicy("PharmacyStaffOnly", policy => policy.RequireClaim("EmployeePosition", "PharmacyStaff"));
                options.AddPolicy("RetailStaffOnly", policy => policy.RequireClaim("EmployeePosition", "RetailStaff"));
            });

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
            services.AddScoped<IRecommenderSystemService, RecommenderSystemService>();
            services.AddHttpContextAccessor().AddScoped<CurrentUser>().AddSingleton<ClaimsPrincipalAccessor>();
            services.AddMemoryCache();
            services.AddSignalR();
            services.AddScoped<MessageHub>();

        }

    }
}
