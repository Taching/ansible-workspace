.PHONY: setup update dotfiles extensions preflight

setup:
	./bootstrap.sh

preflight:
	@set -e; \
	if ! command -v brew >/dev/null 2>&1; then \
		if [ -x /opt/homebrew/bin/brew ]; then eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		elif [ -x /usr/local/bin/brew ]; then eval "$$(/usr/local/bin/brew shellenv)"; \
		fi; \
	fi; \
	command -v brew >/dev/null 2>&1 || { echo "Homebrew is required. Install from https://brew.sh/"; exit 1; }; \
	command -v ansible-playbook >/dev/null 2>&1 || { echo "Ansible is required. Run: brew install ansible"; exit 1; }; \
	mkdir -p ~/Work; \
	mkdir -p ~/.ansible/tmp; \
	curl -fsS -I https://galaxy.ansible.com/api/ >/dev/null; \
	if [ "$${GALAXY_IGNORE_CERTS:-}" = "1" ]; then \
		ansible-galaxy collection install -r requirements.yml --ignore-certs; \
	else \
		ansible-galaxy collection install -r requirements.yml; \
	fi; \
	ansible-playbook --syntax-check -i inventory main.yml

update:
	ansible-galaxy collection install -r requirements.yml --force
	ansible-playbook main.yml --ask-become-pass

dotfiles:
	ansible-playbook main.yml --ask-become-pass --tags dotfiles

extensions:
	ansible-playbook main.yml --ask-become-pass --tags extensions
