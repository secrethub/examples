This example demonstrates how to deploy an ASP.NET application that uses the SecretHub .NET client to Azure.

## Deploying the example
The example can be deployed as described in the following Azure App Service deployment guide:
[https://docs.microsoft.com/en-us/azure/app-service/quickstart-dotnetcore?pivots=platform-linux](https://docs.microsoft.com/en-us/azure/app-service/quickstart-dotnetcore?pivots=platform-linux)

Since the SecretHub .NET Client does not support 32 bit environments, the deployment must be configured to run in a 64 bit container.
This can be done by opening the App Service on the Azure Portal, going to Settings -> Configuration -> General Settings -> Platform Settings and setting the Platform to `64 bit`.

To allow the SecretHub .NET Client to fetch and decrypt secrets from the SecretHub API, a service credential must be provided to it.

First, run the following command on your local workstation to create a service credential:
```bash
secrethub service init --permission read your-company/your-repo
```

Copy the outputted service credential and add it as an Application Setting named `SECRETHUB_CREDENTIAL`. This can be done by navigating to Settings -> Configuration -> Application Settings -> New Application Setting and adding the new setting.

This Demo Application also makes use the `DEMO_USERNAME_PATH` and `DEMO_PASSWORD_PATH` environment variables, which should be set to the following values:
```
DEMO_USERNAME_PATH=your-username/demo/username
DEMO_PASSWORD_PATH=your-username/demo/password
```
These can be configured in the Application Settings as described in the previous step.

To make sure that these secrets exist run `secrethub demo init`.

## Running the example locally
To run the example locally you must either have a SecretHub account configured locally or set the `SECRETHUB_CREDENTIAL` environment variable to a valid SecretHub credential (as described in the previous step).

Configure the `DEMO_USERNAME_PATH` and `DEMO_PASSWORD_PATH` environment variables as described in the previous step.

Afterwards the example can be run with the dotnet CLI (for example):
```bash
dotnet run
```
