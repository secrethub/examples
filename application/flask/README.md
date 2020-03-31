# flask application in Docker
This flask example checks if the environment variables `DEMO_USERNAME` and `DEMO_PASSWORD` are set. If they are, the application responds to requests with a status code 200 and a welcome message. If not, the application responds with status code 500.

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

Build the flask docker demo
```
docker build . -t flask:demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -ti -p 8080:5000 \
  -e DEMO_USERNAME=secrethub://<your_username>/demo/username \
  -e DEMO_PASSWORD=secrethub://<your_username>/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  flask:demo
```
