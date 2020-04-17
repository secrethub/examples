# Node.js application in Docker
This Node.js example checks if the environment variables `DEMO_USERNAME` and `DEMO_PASSWORD` are set. If they are, the application responds (at localhost:8080) to the requests with a status code 200 and a welcome message. If not, the application responds with status code 500.

## Prerequisites
1. [Docker](https://docs.docker.com/install/) installed and running
2. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed

## Running the example

Init the SecretHub demo repo with example values
```
secrethub demo init
```

Set the SecretHub username in an environment variable
```
export SECRETHUB_USERNAME=<your-username>
```

Create a service account for the demo repo
```
secrethub service init --description demo_service \
--permission read --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

Build the Node.js docker demo
```
docker build . -t nodejs-secrethub-demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -p 8080:8080 \
  -e DEMO_USERNAME=secrethub://${SECRETHUB_USERNAME}/demo/username \
  -e DEMO_PASSWORD=secrethub://${SECRETHUB_USERNAME}/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  nodejs-secrethub-demo
```

If you now visit http://localhost:8080, you should see the welcome message including your username.
