# .NET CORE 3.1 base image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

# Create new app
RUN dotnet new webApp -o myWebApp --no-https
COPY ./myWebApp ./myWebApp
WORKDIR ./myWebApp
EXPOSE 5000
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:5000"]