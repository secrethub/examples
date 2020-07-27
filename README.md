<p align="center">
  <img src="https://secrethub.io/img/secrethub-logo.svg" alt="SecretHub" width="380px"/>
</p>
<h1 align="center">
  <i>Examples</i>
</h1>

[![Discord](https://img.shields.io/badge/chat-on%20discord-7289da.svg?logo=discord)](https://discord.gg/NWmxVeb)

> [SecretHub][secrethub] is a secrets management tool that works for every engineer. Securely provision passwords and keys throughout your entire stack with just a few lines of code.

This repository contains code examples for integrations with SecretHub. The README.md for these examples can be found in every directory. For all integrations, take a look at the [integrations page](https://secrethub.io/docs/#integrations).

We're adding more examples over time (starting with the ones listed below), so keep a lookout for new examples. We'll be adding the ones listed here first.

If you have a great example of a SecretHub integration yourself or a way to improve an example, feel free (and very welcome) to make a pull request.

## Examples

* CI/CD
  * [CircleCI](ci/circleci/)
  * [GitHub Actions](ci/github-actions/publish-docker/.github/workflows/main.yml)
  * Travis CI
  * [GitLab CI](ci/gitlab-ci/)
  * Jenkins
* Cloud
  * [AWS EC2](aws/ec2)
  * [AWS ECS](aws/ecs/)
  * AWS Lambda (Golang)
  * [Google Compute Engine](google-cloud/gce)
  * [Google Kubernetes Engine](google-cloud/gke)
  * Linux VMS
* Application
  * [Flask](application/flask)
  * [Django](application/django)
  * [Node.js](application/nodejs)
  * [Ruby](application/ruby)
  * [Rails](application/rails)
  * [Spring-boot](application/spring-boot)
  * [ASP.NET](application/aspnet)
* DevOps tools
  * Terraform
  * Ansible
  * Chef
  * Puppet
* IDE
  * VS Code

[secrethub]: https://secrethub.io/
