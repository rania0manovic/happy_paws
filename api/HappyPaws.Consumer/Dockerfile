
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 5137
ENV ASPNETCORE_URL=http://+:5137

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
#COPY ["HappyPaws.Common/HappyPaws.Common.csproj", "HappyPaws.Common/"]
#COPY ["HappyPaws.Core/HappyPaws.Core.csproj", "HappyPaws.Core/"]
COPY . .

FROM build AS publish
RUN dotnet publish "HappyPaws.Consumer/HappyPaws.Consumer.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HappyPaws.Consumer.dll"]