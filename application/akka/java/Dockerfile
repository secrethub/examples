FROM mozilla/sbt:latest

# Install SecretHub
RUN curl -sLJO https://deb.secrethub.io/amd64 && \
    dpkg -i secrethub-cli-amd64.deb && \
    rm secrethub-cli-amd64.deb

COPY example ./example/

WORKDIR ./example/

RUN sbt update

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["sbt", "run"]
