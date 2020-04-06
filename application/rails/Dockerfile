FROM ruby:2.7
RUN mkdir /myapp
WORKDIR /myapp

# Install SecretHub
RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

# Install rails
RUN gem install rails

# Create Secrethub Demo app
RUN rails new secrethub_demo --api --skip-active-record

# Copy source files
COPY routes.rb                   /myapp/secrethub_demo/config/routes.rb
COPY application_controller.rb   /myapp/secrethub_demo/app/controllers/application_controller.rb

# Change workdir
WORKDIR /myapp/secrethub_demo/

# Expose rails standard port
EXPOSE 3000

# Add the secrethub entrypoint
ENTRYPOINT ["secrethub","run","--"]

# Start the main process
CMD ["rails","server","-b","0.0.0.0"]
