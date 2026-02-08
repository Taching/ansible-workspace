.PHONY: setup update dotfiles extensions preflight

setup:
	./bootstrap.sh

preflight:
	@set -e; \
	command -v brew >/dev/null 2>&1 || { echo "Homebrew is required. Install from https://brew.sh/"; exit 1; }; \
	command -v ansible-playbook >/dev/null 2>&1 || { echo "Ansible is required. Run: brew install ansible"; exit 1; }; \
	mkdir -p ~/Work; \
	mkdir -p ~/.ansible/tmp; \
	curl -fsS -I https://galaxy.ansible.com/api/ >/dev/null; \
	ansible-galaxy collection install -r requirements.yml; \
	ansible-playbook --syntax-check -i inventory main.yml

update:
	ansible-galaxy collection install -r requirements.yml --force
	ansible-playbook main.yml --ask-become-pass

dotfiles:
	ansible-playbook main.yml --ask-become-pass --tags dotfiles

extensions:
	ansible-playbook main.yml --ask-become-pass --tags extensions
