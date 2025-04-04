FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app

COPY . .
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app

COPY --from=build /publish .

# use port 5005
EXPOSE 5005

ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]
