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

# Use exa instead of ls (https://github.com/ogham/exa#command-line-options)
alias ls="exa -FgH"

# Display rotation
rotate_screen() {
  local -r degree="$1"
  displayplacer "id:795A34FA-BB0F-4BEF-BC01-DA777CE713A6 degree:$degree" &>/dev/null
  return 0
}

alias hscreen="rotate_screen 0"
alias vscreen="rotate_screen 270"

# Custom aliases
