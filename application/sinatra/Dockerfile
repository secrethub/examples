FROM ruby:2.7-slim
WORKDIR /app
COPY . /app

# Install SecretHub
RUN echo "deb [trusted=yes] https://apt.secrethub.io stable main" > /etc/apt/sources.list.d/secrethub.sources.list && apt-get update
RUN apt-get install -y secrethub-cli

# Install Gemfile
RUN bundle update
RUN bundle install

# Expose sinatra standard port 4567
EXPOSE 4567

# Add the secrethub entrypoint
ENTRYPOINT ["secrethub","run","--"]

# Start the main process
CMD ["ruby", "myapp.rb"]
