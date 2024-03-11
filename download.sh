#!/bin/bash
set -eox pipefail

DESTINATION="${1:-dotfiles}"

mkdir -p "${DESTINATION}"
curl -L https://github.com/Kylmakalle/dotfiles/archive/refs/heads/main.tar.gz -o "dotfiles.tar.gz"
tar -xzf "dotfiles.tar.gz" --strip-components=1 -C "${DESTINATION}" && rm "dotfiles.tar.gz"
