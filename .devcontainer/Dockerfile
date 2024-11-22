# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

COPY start-docker-osx /usr/local/bin/start-docker-osx

# Expose the ports for SSH and VNC
EXPOSE 50924
EXPOSE 6002

# Set the entrypoint to run the start script
ENTRYPOINT ["/bin/bash"]