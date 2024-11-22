FROM sickcodes/docker-osx:latest

# Install required packages
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    sudo \
    curl \
    git \
    vim \
    openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Setup KVM permissions
RUN usermod -aG kvm $USERNAME

WORKDIR /workspace

USER $USERNAME

# Copy launch script
COPY Launch.sh /workspace/
RUN sudo chmod +x /workspace/Launch.sh