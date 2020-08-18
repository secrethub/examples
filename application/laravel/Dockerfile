FROM composer:latest

# RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

RUN composer create-project laravel/laravel demo

WORKDIR ./demo

RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

COPY .env ./.env
COPY welcome.blade.php ./resources/views/welcome.blade.php

# Expose Laravel standard port
EXPOSE 8000

# # # Add the SecretHub entry point
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
