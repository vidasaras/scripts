#!/bin/bash

# Script to remount myfs every second

MOUNT_POINT="/mnt"

while true; do
    # Unmount if already mounted
    if mountpoint -q "$MOUNT_POINT"; then
        sudo umount "$MOUNT_POINT"
    fi

    # Mount myfs
    sudo mount -t virtiofs myfs "$MOUNT_POINT"

    # Wait for 1 second
    sleep 1
done
