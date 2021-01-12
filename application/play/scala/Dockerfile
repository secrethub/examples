FROM mozilla/sbt:latest

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64
RUN dpkg -i secrethub-cli-amd64.deb
RUN rm secrethub-cli-amd64.deb

COPY example ./example/

WORKDIR ./example/

# Download project's dependencies
RUN sbt update

# Expose Play Framework standard port 9000
EXPOSE 9000

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]

