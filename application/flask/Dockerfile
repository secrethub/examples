FROM python:3.7-alpine
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Expose flask standard port 5000
EXPOSE 5000

# # Add the SecretHub entrypoint
ENTRYPOINT ["secrethub","run","--"]

# Start the main process
CMD ["python","app.py"]
