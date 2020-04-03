FROM node:10-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Expose http-server standard port
EXPOSE 8080

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub","run","--"]

# Start the main process
CMD ["npm","start"]
