#!/bin/sh
# Description: Build the kernel with a specified KERNCONF using all CPU cores
# Usage: ./buildkernel.sh KERNCONF_NAME

if [ $# -ne 1 ]; then
    echo "Usage: $0 KERNCONF_NAME"
    exit 1
fi

KCONF="$1"

make -j"$(sysctl -n hw.ncpu)" KERNCONF="$KCONF" kernel -DWITHOUT_CLEAN > /tmp/kernel.log 2>&1
