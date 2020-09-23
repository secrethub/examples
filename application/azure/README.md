This example demonstrates how to use SecretHub .NET client in an ASP.NET application.

## Prerequisites
1. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
1. A SecretHub repo that contains a `username` and `password` secret. To create it, run `secrethub demo init`.
1. Have the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/) installed

## Running the example
To make it easier to follow upcoming steps, export your SecretHub username to an environment variable:
```
export SECRETHUB_USERNAME=<your-username>
```

This example expects the following two environment variables to be set to secret paths.

To set them, run the following commands:
```
export DEMO_USERNAME_PATH=${SECRETHUB_USERNAME}/demo/username
export DEMO_PASSWORD_PATH=${SECRETHUB_USERNAME}/demo/password
```

Create a service account for the demo repo
```
secrethub service init --description demo_service \
--permission read --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

Build the ASP.NET docker demo
```
docker build . -t aspnet-secrethub-demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -p 8080:5000 \
  -e DEMO_USERNAME=secrethub://${SECRETHUB_USERNAME}/demo/username \
  -e DEMO_PASSWORD=secrethub://${SECRETHUB_USERNAME}/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  aspnet-secrethub-demo
```

If you now visit http://localhost:8080, you should see the welcome message including your username.


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
These can be configured in the Application Settings, just like the `SECRETHUB_CREDENTIAL`.

To make sure that these secrets exist run `secrethub demo init`.
