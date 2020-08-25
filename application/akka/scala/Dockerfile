FROM mozilla/sbt:latest

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

# Create Akka Framework project template in Scala
RUN printf 'demo\n\ndemo\n' | sbt new akka/akka-scala-seed.g8

COPY AkkaQuickstart.scala demo/src/main/scala/demo/AkkaQuickstart.scala

WORKDIR ./demo/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]
