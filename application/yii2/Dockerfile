FROM composer:1.10.10

# Initialize Yii2 project
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic example

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Define working directory
WORKDIR ./example

#Copy the modified file
COPY . .

# Expose default Yii2 port
EXPOSE 8080

# Add the SecretHub entry point
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["php", "yii", "serve", "0.0.0.0", "--port=8080"] 
