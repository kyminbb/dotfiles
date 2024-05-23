#!/bin/bash

# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto # update automatically without asking
# shellcheck disable=SC2034
plugins=(git history macos zsh-autosuggestions zsh-syntax-highlighting)
# shellcheck disable=SC1091
source "$ZSH/oh-my-zsh.sh"

# Init Starship
eval "$(starship init zsh)"

# Pyenv config
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"

# Pipenv config
export PIPENV_VENV_IN_PROJECT=1

# Go tool config
export PATH="$PATH:$HOME/go/bin"

# Cargo config
export PATH="$PATH:$HOME/.cargo/bin"

# Use eza instead of ls (https://eza.rocks/)
alias ls="eza -F"

# Custom aliases
