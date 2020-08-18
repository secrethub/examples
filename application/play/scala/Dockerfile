# Build app using Maven
FROM mozilla/sbt:latest

RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb
RUN printf 'demo\ndemo\n' | sbt new playframework/play-scala-seed.g8
# Install SecretHub

COPY application.conf demo/conf/application.conf
COPY HomeController.scala demo/app/controllers/HomeController.scala

WORKDIR ./demo/

# Expose spring boot standard port 8080
EXPOSE 9000

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]

