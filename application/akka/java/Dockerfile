FROM maven:ibmjava-alpine

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Install sbt
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add sbt

# Create Akka Framework project template in Java
RUN printf 'demo\n\ndemo\n' | sbt new akka/akka-java-seed.g8

COPY AkkaQuickstart.java demo/src/main/java/demo/AkkaQuickstart.java

WORKDIR demo/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["mvn", "compile", "exec:exec"]
