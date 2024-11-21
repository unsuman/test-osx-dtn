#!/bin/bash

# Clone the necessary repositories
git clone --recurse-submodules --depth 1 https://github.com/kholia/OSX-KVM.git /home/arch/OSX-KVM
git clone --recurse-submodules --depth 1 --branch "${BRANCH:=master}" "${REPO:=https://github.com/sickcodes/Docker-OSX.git}" /home/arch/Docker-OSX

# Set up the environment variables
export BASESYSTEM_IMAGE=${BASESYSTEM_IMAGE:-BaseSystem.img}
export SHORTNAME=${SHORTNAME:-catalina}
export BOOTDISK=${BOOTDISK:-/home/arch/OSX-KVM/OpenCore/OpenCore.qcow2}
export ENV=${ENV:-/env}
export WIDTH=${WIDTH:-1920}
export HEIGHT=${HEIGHT:-1080}
export MASTER_PLIST_URL=${MASTER_PLIST_URL:-https://raw.githubusercontent.com/sickcodes/osx-serial-generator/master/config-custom.plist}

# Download and convert the BaseSystem image if it doesn't exist
if ! [[ -e "${BASESYSTEM_IMAGE}" ]]; then
    printf '%s\n' "No BaseSystem.img available, downloading ${SHORTNAME}"
    make -C /home/arch/OSX-KVM
    qemu-img convert BaseSystem.dmg -O qcow2 -p -c ${BASESYSTEM_IMAGE}
    rm ./BaseSystem.dmg
fi

# Set up permissions for /dev/kvm and /dev/snd
sudo touch /dev/kvm /dev/snd "${IMAGE_PATH}" "${BOOTDISK}" "${ENV}" 2>/dev/null || true
sudo chown -R $(id -u):$(id -g) /dev/kvm /dev/snd "${IMAGE_PATH}" "${BOOTDISK}" "${ENV}" 2>/dev/null || true

# Configure the boot disk based on NOPICKER
if [[ "${NOPICKER}" == true ]]; then
    sed -i '/^.*InstallMedia.*/d' /home/arch/OSX-KVM/Launch.sh
    export BOOTDISK="${BOOTDISK:=/home/arch/OSX-KVM/OpenCore/OpenCore-nopicker.qcow2}"
else
    export BOOTDISK="${BOOTDISK:=/home/arch/OSX-KVM/OpenCore/OpenCore.qcow2}"
fi

# Generate unique machine values if requested
if [[ "${GENERATE_UNIQUE}" == true ]]; then
    /home/arch/Docker-OSX/osx-serial-generator/generate-unique-machine-values.sh \
        --master-plist-url="${MASTER_PLIST_URL}" \
        --count 1 \
        --tsv ./serial.tsv \
        --bootdisks \
        --width "${WIDTH}" \
        --height "${HEIGHT}" \
        --output-bootdisk "${BOOTDISK}" \
        --output-env "${ENV}" || exit 1
fi

# Generate specific machine values if requested
if [[ "${GENERATE_SPECIFIC}" == true ]]; then
    source "${ENV}" 2>/dev/null
    /home/arch/Docker-OSX/osx-serial-generator/generate-specific-bootdisk.sh \
        --master-plist-url="${MASTER_PLIST_URL}" \
        --model "${DEVICE_MODEL}" \
        --serial "${SERIAL}" \
        --board-serial "${BOARD_SERIAL}" \
        --uuid "${UUID}" \
        --mac-address "${MAC_ADDRESS}" \
        --width "${WIDTH}" \
        --height "${HEIGHT}" \
        --output-bootdisk "${BOOTDISK}" || exit 1
fi

# Enable SSH
/home/arch/OSX-KVM/enable-ssh.sh

# Run the Launch script
/bin/bash -c /home/arch/OSX-KVM/Launch.sh
