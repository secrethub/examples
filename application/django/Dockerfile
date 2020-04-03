FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/

# Install essentials for Django
RUN apk add --no-cache --virtual .build-deps \
    ca-certificates gcc postgresql-dev linux-headers musl-dev \
    libffi-dev jpeg-dev zlib-dev \
    && pip install -r requirements.txt

# Install SecretHub
RUN apk add --repository https://alpine.secrethub.io/alpine/edge/main --allow-untrusted secrethub-cli

# Let django-admin set up the framework
RUN django-admin startproject project .

# Copy example code
COPY urls.py /code/project/urls.py
COPY views.py views.py

# Expose django standard port 8000
EXPOSE 8000

# Add the SecretHub entrypoint
ENTRYPOINT ["secrethub","run","--"]

# Start the main process
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
