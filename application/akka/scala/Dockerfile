FROM mozilla/sbt:latest

RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb
RUN printf 'demo\n\ndemo\n' | sbt new akka/akka-scala-seed.g8
# Install SecretHub

COPY application.conf demo/conf/application.conf
COPY AkkaQuickstart.scala demo/src/main/scala/demo/AkkaQucikstart.scala

WORKDIR ./demo/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]
