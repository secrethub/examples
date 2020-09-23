<p align="center">
  <img src="https://secrethub.io/img/integrations/aspnet/github-banner.png?v1" alt="ASP.NET + SecretHub" height="230">
</p>
<br/>

This ASP.NET using the SecretHub .NET SDK example checks if the environment variables `DEMO_USERNAME` and `DEMO_PASSWORD` have been set. If that's the case, you'll receive a `200` on http://localhost:8080 and if it's not, you'll get a `500`.

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

Set the environment variables used by the application and provision the SecretHub credential to the client
```
export DEMO_USERNAME=${SECRETHUB_USERNAME}/demo/username
export DEMO_PASSWORD=${SECRETHUB_USERNAME}/demo/password
export SECRETHUB_CREDENTIAL=$(cat demo_service.cred)
```

```bash
dotnet run
```

If you now visit http://localhost:8080, you should see the welcome message including your username.

## Deploying to Azure App Service
The example can be deployed by following the steps in the [Microsoft Quickstart Guide](https://docs.microsoft.com/en-us/azure/app-service/quickstart-dotnetcore). 

Make sure of the following:
- Pick Basic or higher as the pricing tier (instead of the suggested one).
- Set the Platform to 64 bits. This can be done by going to _Settings_ -> _Configuration_ -> _General Settings_ -> _Platform Settings_ and setting the _Platform_ to `64 bit`.

The environment variables required can be configured as Application Settings, by navigating to _Settings_ -> _Configuration_ -> _Application Settings_ and adding the Application Settings.
