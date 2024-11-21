# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Copy the start script into the container
COPY start-docker-osx.sh /workspace/start-docker-osx.sh

# Make the script executable
RUN chmod +x /workspace/start-docker-osx.sh

# Expose the ports for SSH and VNC
EXPOSE 10022
EXPOSE 5999

# Set the entrypoint to keep the container alive
ENTRYPOINT ["sleep", "infinity"]
