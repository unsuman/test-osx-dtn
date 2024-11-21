#!/bin/bash
set -eux

# Ensure proper ownership of KVM and sound devices
sudo chown    $(id -u):$(id -g) /dev/kvm 2>/dev/null || true
sudo chown -R $(id -u):$(id -g) /dev/snd 2>/dev/null || true

# RAM calculation based on input
if [[ "${RAM}" = max ]]; then
    export RAM="$(("$(head -n1 /proc/meminfo | tr -dc "[:digit:]") / 1000000"))"
elif [[ "${RAM}" = half ]]; then
    export RAM="$(("$(head -n1 /proc/meminfo | tr -dc "[:digit:]") / 2000000"))"
fi

# Ensure sound device permissions again (duplicate from original script)
sudo chown -R $(id -u):$(id -g) /dev/snd 2>/dev/null || true

# QEMU launch command with extensive configuration
exec qemu-system-x86_64 \
    -m ${RAM:-4}000 \
    -cpu ${CPU:-Penryn},${CPUID_FLAGS:-vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check,}${BOOT_ARGS} \
    -machine q35,${KVM-"accel=kvm:tcg"} \
    -smp ${CPU_STRING:-${SMP:-4},cores=${CORES:-4}} \
    -device qemu-xhci,id=xhci \
    -device usb-kbd,bus=xhci.0 -device usb-tablet,bus=xhci.0 \
    -device isa-applesmc,osk=ourhardworkbythesewordsguardedpleasedontsteal\(c\)AppleComputerInc \
    -drive if=pflash,format=raw,readonly=on,file=/home/arch/OSX-KVM/OVMF_CODE.fd \
    -drive if=pflash,format=raw,file=/home/arch/OSX-KVM/OVMF_VARS-1024x768.fd \
    -smbios type=2 \
    -audiodev ${AUDIO_DRIVER:-alsa},id=hda -device ich9-intel-hda -device hda-duplex,audiodev=hda \
    -device ich9-ahci,id=sata \
    -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file=${BOOTDISK:-/home/arch/OSX-KVM/OpenCore/OpenCore.qcow2} \
    -device ide-hd,bus=sata.2,drive=OpenCoreBoot \
    -device ide-hd,bus=sata.3,drive=InstallMedia \
    -drive id=InstallMedia,if=none,file=/home/arch/OSX-KVM/BaseSystem.img,format=${BASESYSTEM_FORMAT:-qcow2} \
    -drive id=MacHDD,if=none,file=${IMAGE_PATH:-/home/arch/OSX-KVM/mac_hdd_ng.img},format=${IMAGE_FORMAT:-qcow2} \
    -device ide-hd,bus=sata.4,drive=MacHDD \
    -netdev user,id=net0,hostfwd=tcp::${INTERNAL_SSH_PORT:-10022}-:22,hostfwd=tcp::${SCREEN_SHARE_PORT:-5900}-:5900,${ADDITIONAL_PORTS} \
    -device ${NETWORKING:-vmxnet3},netdev=net0,id=net0,mac=${MAC_ADDRESS:-52:54:00:09:49:17} \
    -monitor stdio \
    -boot menu=on \
    -vga vmware \
    ${EXTRA:-}