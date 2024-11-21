# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Copy the start script into the container
COPY start-docker-osx.sh /usr/local/bin/start-docker-osx.sh

# Set execute permissions for the start script
RUN chmod +x /usr/local/bin/start-docker-osx.sh

# Expose the ports for SSH and VNC
EXPOSE 50925
EXPOSE 6003

# Set the entrypoint to run the start script
ENTRYPOINT ["/bin/bash"]