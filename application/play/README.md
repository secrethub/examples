<p align="center">
  <img src="https://secrethub.io/img/integrations/play-framework/github-banner.png" alt="Play + SecretHub" height="230">
</p>
<br/>

This Play example checks if the environment variables `DEMO_USERNAME` and `DEMO_PASSWORD` have been set. If that's the case, you'll receive a `200` on http://localhost:9000 and if it's not, you'll get a `500`.

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
--permission read --file demo_service.cred ${SECRETHUB_USERNAME}/demo
```

Build the play docker demo. You can choose `java` or `scala`, depending on which language you want to see the example in action.
```
docker build {java | scala} -t play-secrethub-demo
```

Run the docker demo with the secrets in the environment variables
```
docker run -ti -p 9000:9000 \
  -e DEMO_USERNAME=secrethub://${SECRETHUB_USERNAME}/demo/username \
  -e DEMO_PASSWORD=secrethub://${SECRETHUB_USERNAME}/demo/password \
  -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) \
  play-secrethub-demo
```

If you now visit http://localhost:9000, you should see the welcome message including your username.

