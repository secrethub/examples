This Azure App Service presents how to use SecretHub-XGO library in a C# project.

## Prerequisites
1. [Docker](https://docs.docker.com/install/) installed and running
1. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
1. A SecretHub repo that contains a `username` and `password` secret. To create it, run `secrethub demo init`.

## Running the example

Set the SecretHub username in an environment variable
```
export SECRETHUB_USERNAME=<your-username>
```

Create a service account for the demo repo
```
secrethub service init --description demo_service \
--permission admin --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

Build the Azure App Service docker demo
```
docker build . -t azureapp-secrethub-demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -p 8080:80 \
  -e DEMO_USERNAME=${SECRETHUB_USERNAME}/demo/username \
  -e DEMO_PASSWORD=${SECRETHUB_USERNAME}/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  azureapp-secrethub-demo
```

If you now visit http://localhost:8080, you should see a welcome message, as well as other messages that show how the library works.
