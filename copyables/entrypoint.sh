#!/bin/bash

echo "Start entrypoint.sh"

set -e


echo "Generating SSH host keys..."
ssh-keygen -A

if [ -z "${USER_PASSWORD}" ]; then
    echo "ERROR: USER_PASSWORD environment variable is not set."
    exit 1
fi

echo "Setting root password..."
echo "root:${USER_PASSWORD}" | chpasswd

echo "Starting SSH server..."

exec "$@"
