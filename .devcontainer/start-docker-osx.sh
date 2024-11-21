#!/bin/bash

docker run -i \
    --device /dev/kvm \
    -p 50925:10022 \
    -p 6002:5999 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -e EXTRA="-display none -vnc 0.0.0.0:99,password=off" \
    -e SHORTNAME=ventura \
    sickcodes/docker-osx:latest