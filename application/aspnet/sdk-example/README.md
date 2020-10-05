<p align="center">
  <img src="https://secrethub.io/img/integrations/aspnet/github-banner.png?v1" alt="ASP.NET + SecretHub" height="230">
</p>
<br/>

In contrast with the CLI example, the SDK example does not require any environment variable manipulation. Following the below steps results in an welcome message on http://localhost:5000. If anything shall occur, you will receive an appropriate error message at the same address.

## Prerequisites
1. [Docker](https://docs.docker.com/install/) installed and running
1. [SecretHub](https://secrethub.io/docs/start/getting-started/#install) installed
1. A SecretHub repo that contains a `username` and `password` secret. To create it, run `secrethub demo init`.

## Running the example

Build the ASP.NET docker demo
```
docker build . -t aspnet-secrethub-demo
```

Run the docker demo, mounting your credential in the container and specifying your username through an environment variable.
```
docker run -v $HOME/.secrethub/credential:/root/.secrethub/credential -p 5000:5000 -e SECRETHUB_USERNAME=<your-secrethub-username> aspnet-secrethub-demo
```

If you now visit http://localhost:5000, you should see the welcome message including your username.
