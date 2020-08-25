FROM maven:ibmjava-alpine

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Install sbt
ENV SBT_VERSION  1.3.13
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# Install sbt
RUN apk add --update curl ca-certificates bash && \
	curl -sL "https://piccolo.link/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local && \
  echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built &&\
  apk del curl

# Create Akka Framework project template in Java
RUN printf 'demo\n\ndemo\n' | sbt new akka/akka-java-seed.g8

COPY AkkaQuickstart.java demo/src/main/java/demo/AkkaQuickstart.java

WORKDIR ./demo/

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["mvn", "compile", "exec:exec"]
