FROM elixir:latest

RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

RUN mix local.hex --force

RUN mix archive.install hex phx_new 1.5.4 --force

RUN mix phx.new hello_phoenix_api --no-ecto

COPY ./hello_phoenix_api/lib/hello_phoenix_api_web/router.ex                       ./hello_phoenix_api/lib/hello_phoenix_api_web/router.ex
COPY ./hello_phoenix_api/lib/hello_phoenix_api_web/views/hello_view.ex             ./hello_phoenix_api/lib/hello_phoenix_api_web/views/hello_view.ex
COPY ./hello_phoenix_api/lib/hello_phoenix_api_web/controllers/hello_controller.ex ./hello_phoenix_api/lib/hello_phoenix_api_web/controllers/hello_controller.ex

EXPOSE 4000

WORKDIR ./hello_phoenix_api

RUN mix deps.get --force
RUN mix local.rebar --force

ENTRYPOINT ["secrethub", "run", "--"]

CMD ["mix", "phx.server"] 