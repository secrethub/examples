<p align="center">
  <img src="https://secrethub.io/img/integrations/aspnet/github-banner.png?v1" alt="ASP.NET + SecretHub" height="230">
</p>
<br/>

In contrast with the CLI example, the SDK example requires less interaction with environment variables, as it is a native integration for C#. Following the below steps will result in an welcome message on http://localhost:5000. If any error shall occur, you will receive an appropriate descriptive message at the same address.

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

Build the ASP.NET docker demo
```
docker build . -t aspnet-secrethub-demo
```

Run the docker demo, passing the newly created service credential and your username as environment variables.
```
docker run -e SECRETHUB_CREDENTIAL=$(cat demo_service.cred) -e \
SECRETHUB_USERNAME=${SECRETHUB_USERNAME} -p 5000:5000 aspnet-secrethub-demo
```

If you now visit http://localhost:5000, you should see the welcome message including your username.
