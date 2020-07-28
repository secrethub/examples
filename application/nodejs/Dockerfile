FROM node:13.13-alpine
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Expose http-server standard port
EXPOSE 8080

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["npm", "start"]
