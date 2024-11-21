# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Create a directory for the script
RUN mkdir -p /tmp/scripts

# Copy the start script into the container
COPY start-docker-osx.sh /tmp/scripts/start-docker-osx.sh

# Expose the ports for SSH and VNC
EXPOSE 50924
EXPOSE 6002

# Set the entrypoint to run the start script
ENTRYPOINT ["/tmp/scripts/start-docker-osx.sh"]