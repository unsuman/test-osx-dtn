FROM ubuntu:20.04

# Create the vscode user
RUN useradd -ms /bin/bash vscode

# Install required packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    sudo \
    curl \
    git \
    vim \
    openssh-server \
    docker.io \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Start Docker daemon (optional, if you want to run Docker daemon inside the container)
CMD ["dockerd"]