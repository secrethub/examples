FROM swift:5.2.5

RUN apt-get update

RUN apt-get install -y openssl libssl-dev uuid-dev

RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

RUN git clone https://github.com/PerfectlySoft/PerfectTemplate.git

COPY  /PerfectTemplate/Sources/PerfectTemplate/main.swift /PerfectTemplate/Sources/PerfectTemplate/main.swift
WORKDIR ./PerfectTemplate
RUN swift build

EXPOSE 8181
ENTRYPOINT [ "secrethub", "run", "--"]
CMD ["/PerfectTemplate/.build/debug/PerfectTemplate"]
