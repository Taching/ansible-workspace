#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Press any key after Xcode CLI tools installation completes..."
  read -n 1
fi

if [ "${SKIP_BREW_INSTALL:-}" = "1" ]; then
  echo "==> Skipping Homebrew install (SKIP_BREW_INSTALL=1)."
else
  if command -v brew &>/dev/null; then
    echo "==> Homebrew already installed. Skipping install."
  else
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

echo "==> Installing Ansible..."
brew install ansible

echo "==> Installing Ansible Galaxy requirements..."
: "${GALAXY_IGNORE_CERTS:=1}"
if [ "${GALAXY_IGNORE_CERTS}" = "1" ]; then
  ansible-galaxy collection install -r requirements.yml --ignore-certs
else
  ansible-galaxy collection install -r requirements.yml
fi

echo "==> Caching sudo credentials for Homebrew installs..."
sudo -v
# Keep sudo alive while the playbook runs.
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID' EXIT

echo "==> Running playbook..."
ansible-playbook main.yml --ask-become-pass

echo "==> Setup complete! Restart your terminal to apply changes."
