# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Copy the start script into the container
COPY start-docker-osx.sh /workspace/start-docker-osx.sh

# Expose the ports for SSH and VNC
EXPOSE 50923
EXPOSE 6001

# Set the entrypoint to keep the container alive
ENTRYPOINT ["sleep", "infinity"]
