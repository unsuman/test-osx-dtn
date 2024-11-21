# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Install Docker CLI
RUN pacman -Syu --noconfirm docker

# Copy the start script into the container
COPY start-docker-osx.sh /usr/local/bin/start-docker-osx.sh
COPY enable-ssh.sh /usr/local/bin/enable-ssh.sh
COPY Launch.sh /usr/local/bin/Launch.sh

# Ensure the start script has execution permissions
RUN chmod +x /usr/local/bin/start-docker-osx.sh /usr/local/bin/enable-ssh.sh /usr/local/bin/Launch.sh

# Expose the ports for SSH and VNC
EXPOSE 50922
EXPOSE 5999

# Set the entrypoint to run the start script
ENTRYPOINT ["/bin/bash", "/usr/local/bin/start-docker-osx.sh"]