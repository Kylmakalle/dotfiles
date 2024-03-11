#!/bin/bash

set -euo pipefail

command_installed() {
    if command -v "$1" &> /dev/null
    then
        return 0
    else
        return 1
    fi
}

test -d .venv || python3 -m venv .venv
. .venv/bin/activate

echo ""

if ! command_installed ansible; then
    echo "Installing ansible..."
    pip3 --disable-pip-version-check install ansible
else
    echo "Ansible $(ansible --version) already installed"
fi

echo "Installing ansible dependencies..."
ansible-galaxy install -r requirements.yml
