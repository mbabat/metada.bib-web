FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY metadata.bib-web.com/*.csproj ./metadata.bib-web.com/
RUN dotnet restore

# copy everything else and build app
COPY metadata.bib-web.com/. ./metadata.bib-web.com/
WORKDIR /app/metadata.bib-web.com
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /app
COPY --from=build /app/metadata.bib-web.com/out ./
ENTRYPOINT ["dotnet", "metadata.bib-web.com.dll"]
