FROM mozilla/sbt:latest

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

# Create Akka Framework project template in Scala
RUN sbt new akka/akka-scala-seed.g8 -Dsbt.rootdir=true --name=example --package=example 

COPY AkkaQuickstart.scala example/src/main/scala/example/AkkaQuickstart.scala

WORKDIR example/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]
