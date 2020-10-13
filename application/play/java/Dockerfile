FROM mozilla/sbt:latest

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

# Create template Play Framework project in Java
RUN printf 'example\n\n' | sbt new playframework/play-java-seed.g8

WORKDIR ./example/

COPY . .

# Expose Play Framework standard port 9000
EXPOSE 9000

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]

