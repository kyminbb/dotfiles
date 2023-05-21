#!/bin/bash

# oh-my-zsh config
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto # update automatically without asking
# shellcheck disable=SC2034
plugins=(git history macos zsh-autosuggestions zsh-syntax-highlighting)
# shellcheck disable=SC1091
source "$ZSH/oh-my-zsh.sh"

# alacritty config
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Init Starship
eval "$(starship init zsh)"

# Start Docker
colima start &>/dev/null

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

# Custom aliases

# Start tmux if not in VSCode
if [[ "$TERM_PROGRAM" != "vscode" ]] && command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
