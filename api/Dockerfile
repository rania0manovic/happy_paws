
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URL=http://+:8080

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["HappyPaws/HappyPaws.Api.csproj", "HappyPaws/"]
COPY ["HappyPaws.Application/HappyPaws.Application.csproj", "HappyPaws.Application/"]
COPY ["HappyPaws.Common/HappyPaws.Common.csproj", "HappyPaws.Common/"]
COPY ["HappyPaws.Infrastructure/HappyPaws.Infrastructure.csproj", "HappyPaws.Infrastructure/"]
COPY ["HappyPaws.Core/HappyPaws.Core.csproj", "HappyPaws.Core/"]
RUN dotnet restore "HappyPaws/HappyPaws.Api.csproj"
COPY . .
WORKDIR "/src/HappyPaws"
RUN dotnet build "HappyPaws.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HappyPaws.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HappyPaws.Api.dll"]