FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Install SecretHub
RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

RUN mkdir azure
WORKDIR /azure
RUN dotnet new web
COPY *.csproj *.cs ./

# Expose Azure App service standard port 5000
EXPOSE 5000

CMD ["dotnet", "run"]
