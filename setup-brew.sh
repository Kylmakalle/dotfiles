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

# Check if Command Line Tools are already installed
if xcode-select -p &> /dev/null; then
  echo "Command Line Tools for Xcode are already installed."
else
  echo "Command Line Tools for Xcode not found. Installing..."
  echo "Please, CLICK INSTALL and Agree to terms."

  # Trigger the installation of the Command Line Tools
  xcode-select --install &> /dev/null

  # Initialize a counter for logging the wait time
  counter=0

  # Wait for the Command Line Tools installation to finish
  until xcode-select -p &> /dev/null; do
    sleep 10
    ((counter+=10))
    echo "Waiting for Command Line Tools installation to complete... ${counter} seconds elapsed."
  done

  echo "Command Line Tools for Xcode have been successfully installed."
fi

if ! command_installed brew; then
    echo "Installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Updating ~/.zprofile ..."
    if [[ "$(uname -m)" == "arm64" ]]
    then
       eval "$(/opt/homebrew/bin/brew shellenv)"
    else
       eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Skipping brew installation"
fi

echo "Disabling brew analytics..."
brew analytics off

echo "DONE brew setup"