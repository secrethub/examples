This C# example checks if the environment variables `DEMO_USERNAME` and `DEMO_PASSWORD` have been set. If that's the case, you'll receive a `200` on http://localhost:8080 and if it's not, you'll get a `500`.

## Prerequisites
1. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
1. A SecretHub repo that contains a `username` and `password` secret. To create it, run `secrethub demo init`.
1. Have the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/) installed

## Running the example

Set the SecretHub username in an environment variable
```
export SECRETHUB_USERNAME=<your-username>
```

Create a service account for the demo repo
```
secrethub service init --description demo_service \
--permission read --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

```
export DEMO_USERNAME=${SECRETHUB_USERNAME}/demo/username
export DEMO_PASSWORD=${SECRETHUB_USERNAME}/demo/password
export SECRETHUB_CREDENTIAL=$(cat demo_service.cred)
```

```bash
dotnet run
```

If you now visit http://localhost:8080, you should see the welcome message including your username.



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
These can be configured in the Application Settings, just like the `SECRETHUB_CREDENTIAL`.

To make sure that these secrets exist run `secrethub demo init`.

## Running the example locally
To run the example locally you must either have a SecretHub account configured locally or set the `SECRETHUB_CREDENTIAL` environment variable to a valid SecretHub credential (as described in the previous step).

Configure the `DEMO_USERNAME_PATH` and `DEMO_PASSWORD_PATH` environment variables as described in the previous step.

Afterwards the example can be run with the dotnet CLI (for example):
```bash
dotnet run
```
