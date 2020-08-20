FROM composer:latest

# Initialize Yii2 project
RUN composer create-project --prefer-dist yiisoft/yii2-app-basic basic

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

#Copy the modified file
COPY main.php ./basic/views/layouts/main.php

# Expose default Yii2 port
EXPOSE 8080

# Define working directory
WORKDIR ./basic

# Add the SecretHub entry point
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["php", "yii", "serve", "0.0.0.0","--port=8080"] 
