# Ansible Mac Workspace Setup

## Quick start

```bash
./bootstrap.sh
```

## Prerequisites and preflight plan

```bash
make preflight
```

This also creates `~/Work` if it doesn't exist.

If you hit SSL errors with Ansible Galaxy (common behind corporate proxies), run:

```bash
GALAXY_IGNORE_CERTS=1 make preflight
```

## Update

```bash
make update
```

## Notes

- iTerm2 plist is expected at `files/iterm2/com.googlecode.iterm2.plist`.
- Fonts are copied from iCloud Drive:
  `~/Library/Mobile Documents/com~apple~CloudDocs/ansible-setup/fonts/`.
- Yabai scripting addition requires manual setup (SIP/permissions). Keep this as a post-install step.
