# Use the base image from sickcodes
FROM sickcodes/docker-osx:naked

# Install any additional dependencies if needed
# RUN apt-get update && apt-get install -y <dependencies>

# Expose the ports for SSH and the web UI
EXPOSE 10022
EXPOSE 8006

# Set the entrypoint to run the macOS image
ENTRYPOINT ["/bin/bash", "-c", "qemu-system-x86_64 -drive file=/image,format=raw -device isa-applesmc,osk=\"YOUR_OSK_HERE\" -smp 4,cores=2 -m 4G -machine q35,accel=kvm:hvf -usb -device usb-kbd -device usb-mouse -vga std -netdev user,id=net0,hostfwd=tcp::10022-:22 -device e1000,netdev=net0 -nographic"]
