FROM mozilla/sbt:latest

RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb
RUN printf 'demo\ndemo\n' | sbt new akka/akka-scala-seed.g8
# Install SecretHub

COPY application.conf demo/conf/application.conf
COPY HomeController.java demo/app/controllers/HomeController.java

WORKDIR ./demo/

# Expose spring boot standard port 8080
EXPOSE 9000

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]
