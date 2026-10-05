#!/usr/bin/env bash

# Description: Build the kernel with an optional KERNCONF using all CPU cores
# Usage: ./buildkernel.sh [KERNCONF_NAME]

if [[ $EUID -ne 0 ]]; then
    echo "Error: this script must be run as root." >&2
    exit 1
fi

KCONF="${1:-$(uname -i)}"

make -j"$(sysctl -n hw.ncpu)" KERNCONF="$KCONF" buildkernel > /tmp/kernel.log 2>&1
