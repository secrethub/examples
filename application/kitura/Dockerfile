FROM ibmcom/kitura-ubuntu:latest

# Define a working directory
RUN mkdir HelloKitura
WORKDIR ./HelloKitura

# Install SecretHub
RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

# Initialize the application as an executable
RUN swift package init --type executable

# Copy the necessary files
COPY /HelloKitura/Package.swift /HelloKitura/Package.swift
COPY /HelloKitura/Sources/HelloKitura/main.swift /HelloKitura/Sources/HelloKitura/main.swift

# Get the dependencies
RUN swift build

# Expose the default port
EXPOSE 8080

# Wrap the command with 'secrethub run'
ENTRYPOINT [ "secrethub", "run", "--" ]

# Run the application
CMD [ "swift", "run" ]
