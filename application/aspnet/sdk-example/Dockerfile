# .NET CORE 3.1 base image
FROM mcr.microsoft.com/dotnet/core/sdk:3.1

# Create new app
RUN dotnet new webApp -o example --no-https

# Add modified files
COPY ./example ./example

# Change workdir so the run command will be run in project
WORKDIR /example

# Default port
EXPOSE 5000

# Run command, set to receive requests from everywhere (0.0.0.0) on default
CMD ["dotnet", "run", "--urls", "http://0.0.0.0:5000"]
