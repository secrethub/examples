# Build app
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY example/*.csproj ./example/
RUN dotnet restore -r linux-musl-x64

# copy everything else and build app
COPY example/. ./example/
WORKDIR /source/example
RUN dotnet publish -c release -o /app -r linux-musl-x64 --self-contained false --no-restore

# Run app
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine
WORKDIR /app
COPY --from=build /app ./

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Expose aspnet standard port 80
EXPOSE 80

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

CMD ["./example"]
