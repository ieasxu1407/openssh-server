#!/bin/bash

echo "Start entrypoint.sh"

set -e

# SSH host keys
echo "Generating SSH host keys..."
ssh-keygen -A

# Password
if [ -z "${USER_PASSWORD}" ]; then
    echo "ERROR: USER_PASSWORD is not set."
    exit 1
fi

echo "Setting root password..."
echo "root:${USER_PASSWORD}" | chpasswd

# SSH runtime directory
mkdir -p /tmp/sshd

echo "Run sshd"

exec "$@" -o PidFile=/tmp/sshd/sshd.pid
