FROM elixir:1.9.4-alpine

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.4 --force
RUN mix phx.new hello_phoenix_api --no-ecto

EXPOSE 4000

COPY ./example /hello_phoenix_api/lib/hello_phoenix_api_web
WORKDIR ./hello_phoenix_api

RUN mix deps.get --force
RUN mix local.rebar --force

ENTRYPOINT ["secrethub", "run", "--"]
CMD ["mix", "phx.server"] 
