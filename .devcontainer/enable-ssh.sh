#!/bin/bash

# Check if SSH host keys exist, generate if they don't
if [[ ! -f /etc/ssh/ssh_host_rsa_key ]] || 
   [[ ! -f /etc/ssh/ssh_host_ed25519_key ]] || 
   [[ ! -f /etc/ssh/ssh_host_ed25519_key ]]; then
    sudo /usr/bin/ssh-keygen -A
fi

# Start SSH daemon in the background
nohup sudo /usr/sbin/sshd -D &
