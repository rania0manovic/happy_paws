
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 5118
ENV ASPNETCORE_URL=http://+:5118

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "HappyPaws/HappyPaws.Api.csproj" -c Release -o /app
#/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
#/publish .
ENTRYPOINT ["dotnet", "HappyPaws.Api.dll"]