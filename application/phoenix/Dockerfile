FROM elixir:1.9.4

RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

RUN mix local.hex --force
RUN mix archive.install hex phx_new 1.5.4 --force
RUN mix phx.new hello_phoenix_api --no-ecto

EXPOSE 4000

COPY ./hello_phoenix_api /hello_phoenix_api
WORKDIR ./hello_phoenix_api

RUN mix deps.get --force
RUN mix local.rebar --force

ENTRYPOINT ["secrethub", "run", "--"]
CMD ["mix", "phx.server"] 
