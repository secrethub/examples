FROM composer:latest

RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli
RUN mkdir /myapp
WORKDIR /myapp

RUN composer create-project laravel/laravel demo

WORKDIR /demo

#RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

COPY .env /myapp/demo/.env
COPY welcome.blade.php /myapp/demo/resources/views/welcome.blade.php

# RUN php artisan cache:clear

# Expose Laravel standard port
EXPOSE 8000

# # Add the SecretHub entry point
ENTRYPOINT ['secrethub', 'run', '--']

# Start the main process
CMD ['php', 'artisan', 'serve']