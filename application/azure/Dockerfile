# Build app
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY example/ .

# Expose port 5000
EXPOSE 5000

CMD ["dotnet", "run"]
