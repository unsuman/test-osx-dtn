# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Create a directory for the script
RUN mkdir -p /tmp/scripts

# Copy the start script into the container
COPY start-docker-osx.sh /tmp/scripts/start-docker-osx.sh

# Set execute permissions for the start script
RUN chmod +x /tmp/scripts/start-docker-osx.sh

# Expose the ports for SSH and VNC
EXPOSE 50923
EXPOSE 6001

# Set the entrypoint to keep the container alive
ENTRYPOINT ["sleep", "infinity"]