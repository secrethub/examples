# Django application in Docker
This example checks if the environment variables are set with SecretHub run within the Django application. If this is successful, you will receive a code 200 and a Welcome <username> on localhost:8080, if not a code 500 is shown. 

## Prerequisites
1. Docker installed and running
2. SecretHub installed

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

Build the django docker demo
```
docker build . -t django:demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -p 8080:8000 \
  -e DEMO_USERNAME=secrethub://${SECRETHUB_USERNAME}/demo/username \
  -e DEMO_PASSWORD=secrethub://${SECRETHUB_USERNAME}/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  django:demo
```
