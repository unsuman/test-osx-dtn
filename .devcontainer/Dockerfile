FROM sickcodes/docker-osx:latest

# Install development tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY start-docker-osx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-docker-osx.sh