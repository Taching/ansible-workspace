# Oh-My-Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="agnoster"
plugins=(git)
if [ -d "$ZSH" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "oh-my-zsh not found at $ZSH"
fi

# Start new interactive shells in ~/Work when possible.
if [ -t 1 ] && [ "$PWD" = "$HOME" ] && [ -d "$HOME/Work" ]; then
  cd "$HOME/Work"
fi

# Personal aliases
alias work="cd ~/Work"
alias start="npm run dev"
export DEFAULT_USER=$USER

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Homebrew (Apple Silicon + Intel)
ibrew='arch -x86_64 /usr/local/bin/brew'
mbrew='arch -arm64e /opt/homebrew/bin/brew'
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Workflow scripts
source ~/.bin/.local/scripts/workflow.sh

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$HOME/.local/bin:$PATH"
