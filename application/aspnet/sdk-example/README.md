<p align="center">
  <img src="https://secrethub.io/img/integrations/aspnet/github-banner.png?v1" alt="ASP.NET + SecretHub" height="230">
</p>
<br/>

This example demonstrates the use of the [.NET SDK](https://github.com/secrethub/secrethub-dotnet) in an ASP.NET application.
Following the steps below will result in an welcome message on http://localhost:5000.
If any error occurs, you will receive a descriptive error message in the console.

## Prerequisites
1. [Docker](https://docs.docker.com/install/) installed and running
1. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
1. A SecretHub repo that contains a `username` and `password` secret. To create it, run `secrethub demo init`.

## Running the example

Set the SecretHub username in an environment variable.
```
export SECRETHUB_USERNAME=<your-username>
```

Create a service account for the demo repo.
```
secrethub service init --description demo_service \
--permission read --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

Build the ASP.NET docker demo.
```
docker build . -t aspnet-secrethub-demo
```

Run the docker demo, passing the newly created service credential and the paths in the secret store as environment variables.
```
docker run -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
-e DEMO_USERNAME=secrethub://${SECRETHUB_USERNAME}/demo/username \
-e DEMO_PASSWORD=secrethub://${SECRETHUB_USERNAME}/demo/password \
-p 5000:5000 aspnet-secrethub-demo
```

If you now visit http://localhost:5000, you should see the welcome message including your username.
