# Build app using Maven
FROM maven:3-jdk-8 AS build

WORKDIR /build

COPY pom.xml .

RUN mvn dependency:resolve

COPY src/ src/

RUN mvn package

# Run app
FROM openjdk:8-jdk-alpine
COPY --from=build /build/target/example-*.jar /example.jar

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Expose spring boot standard port 8080
EXPOSE 8080

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["java", "-jar", "/example.jar"]
