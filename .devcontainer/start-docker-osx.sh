#!/bin/bash

sudo docker run -i \
    --device /dev/kvm \
    -p 50922:10022 \
    -p 5999:5999 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ${PWD}:/mnt/shared \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e EXTRA="-display none -vnc 0.0.0.0:99,password=off" \
    -e SHORTNAME=ventura \
    sickcodes/docker-osx:latest
