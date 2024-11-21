#!/bin/bash
# Start OSX VM in background
/bin/bash -c "nohup ./Launch.sh &" 

# Wait for VM to be ready
until nc -z localhost 5999; do
  echo "Waiting for VNC port..."
  sleep 5
done

echo "OSX VM is ready! Connect using VNC to localhost:5999"