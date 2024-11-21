# Use the base image from sickcodes
FROM sickcodes/docker-osx:latest

# Copy the start script and other necessary files into the container
COPY start-docker-osx.sh /workspace/start-docker-osx.sh
COPY Makefile /workspace/Makefile
COPY enable-ssh.sh /workspace/enable-ssh.sh

# Make the scripts executable
RUN chmod +x /workspace/start-docker-osx.sh /workspace/enable-ssh.sh

# Install make and other dependencies if needed
RUN apt-get update && apt-get install -y make

# Expose the ports for SSH and VNC
EXPOSE 10022
EXPOSE 6002

# Set the entrypoint to keep the container alive
ENTRYPOINT ["sleep", "infinity"]
