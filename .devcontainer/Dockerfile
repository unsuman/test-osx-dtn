# .devcontainer/Dockerfile
FROM sickcodes/docker-osx:latest

# Using apk package manager since base image is Alpine Linux
RUN apk update && apk add --no-cache \
    curl \
    git \
    wget

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh