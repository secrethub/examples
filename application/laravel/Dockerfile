FROM composer:latest

# Create Laravel project
RUN composer create-project laravel/laravel demo

# Work with the Laravel Project
WORKDIR ./demo

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Copy prerequisite files
COPY .env ./.env
COPY welcome.blade.php ./resources/views/welcome.blade.php

# Expose Laravel standard port
EXPOSE 8000

# Add the SecretHub entry point
ENTRYPOINT ["secrethub", "run", "--"]

# Start the main process
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]