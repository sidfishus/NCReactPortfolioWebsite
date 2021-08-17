#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["NCReactPortfolioWebsite.csproj", "."]
RUN dotnet restore "./NCReactPortfolioWebsite.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "NCReactPortfolioWebsite.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "NCReactPortfolioWebsite.csproj" -c Release -o /app/publish

#//sidtodo try adding a npm install, npm build.

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "NCReactPortfolioWebsite.dll"]