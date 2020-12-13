FROM maven:ibmjava-alpine

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Install sbt
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add sbt

# Create Akka Framework project template in Java
RUN sbt new akka/akka-java-seed.g8 --name=example --package=example

COPY AkkaQuickstart.java example/src/main/java/example/AkkaQuickstart.java

WORKDIR example/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["mvn", "compile", "exec:exec"]
