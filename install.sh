#!/bin/bash

readonly NC="\033[0m"
readonly GREEN="\033[0;32m"
readonly BLUE="\033[0;34m"
readonly BOLD_GREEN="\033[1;32m"
readonly BOLD_WHITE="\033[1;37m"

prompt() {
  echo -e "${2:-$GREEN}==>$BOLD_WHITE $1$NC"
}

brew_install() {
  local flags=()
  while [[ "$1" == -* ]]; do
    flags+=("$1")
    shift
  done
  brew list "$1" >/dev/null || brew install "${flags[@]}" "$1"
}

install_utils() {
  declare -ar formulae=(eza)
  for formula in "${formulae[@]}"; do
    prompt "Installing ${BOLD_GREEN}${formula}"
    brew_install "$formula"
  done
}

install_nvim() {
  prompt "Installing ${BOLD_GREEN}neovim"
  brew_install neovim
  git config --global core.editor "nvim -f"
}

install_ghostty() {
  prompt "Installing ${BOLD_GREEN}Ghostty"
  brew_install --cask ghostty
  cp ghostty/config "$HOME"/Library/Application\ Support/com.mitchellh.ghostty/config
}

init_zsh() {
  # Init oh-my-zsh
  prompt "Installing ${BOLD_GREEN}oh-my-zsh"
  [[ -d $HOME/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  prompt "Installing zsh-autosuggestions" "$BLUE"
  local target_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  [[ -d $target_path ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "$target_path"
  prompt "Installing zsh-syntax-highlighting" "$BLUE"
  target_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  [[ -d $target_path ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "$target_path"

  # Init starship
  prompt "Installing font-rec-mono-nerd-font" "$BLUE"
  brew_install --cask font-recursive-mono-nerd-font
  prompt "Installing ${BOLD_GREEN}starship"
  brew_install starship
  mkdir -p "$HOME"/.config
  cp zsh/starship.toml "$HOME"/.config/starship.toml

  # Init zsh
  prompt "Initializing ${BOLD_GREEN}zsh"
  cp zsh/.zshrc "$HOME"/.zshrc
}

install_utils
install_nvim
install_ghostty
init_zsh
echo -e "\nRun \`source ~/.zshrc\` to apply changes!"
