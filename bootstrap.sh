#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Installing Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "Press any key after Xcode CLI tools installation completes..."
  read -n 1
fi

echo "==> Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing Ansible..."
brew install ansible

echo "==> Installing Ansible Galaxy requirements..."
ansible-galaxy collection install -r requirements.yml

echo "==> Running playbook..."
ansible-playbook main.yml --ask-become-pass

echo "==> Setup complete! Restart your terminal to apply changes."
