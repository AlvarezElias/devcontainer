FROM  mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY devcontainer.net.csproj .
RUN dotnet restore
COPY Program.cs .
RUN dotnet publish -c Release -r linux-x64 --no-self-contained

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /src/bin/Release/net8.0/linux-x64/publish/ .
EXPOSE 8080
ENTRYPOINT ["dotnet", "devcontainer.net.dll"]