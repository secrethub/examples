FROM swift:latest

RUN apt-get update

RUN apt-get upgrade -y && \
    apt-get install -y git

RUN apt-get install -y openssl libssl-dev uuid-dev

RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

COPY /PerfectTemplate /PerfectTemplate
WORKDIR ./PerfectTemplate
RUN swift build

EXPOSE 8181
ENTRYPOINT [ "secrethub", "run", "--"]
CMD ["/PerfectTemplate/.build/debug/PerfectTemplate"]
