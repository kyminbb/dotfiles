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
  brew list "$1" >/dev/null || brew install "$1"
}

init_utils() {
  declare -ar formulae=(exa colima tmux)
  for formula in "${formulae[@]}"; do
    prompt "Installing ${BOLD_GREEN}${formula}"
    brew_install "$formula"
  done
}

init_zsh() {
  # Init oh-my-zsh
  prompt "Installing ${BOLD_GREEN}oh-my-zsh"
  [[ -d $HOME/.oh-my-zsh ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  prompt "Installing zsh-autosuggestions" "$BLUE"
  local target_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  [[ -d $target_path ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "$target_path"
  prompt "Installing zsh-syntax-highlighting" "$BLUE"
  brew_install zsh-syntax-highlighting

  # Init starship
  prompt "Installing ${BOLD_GREEN}starship"
  brew_install starship
  prompt "Installing font-lilex-nerd-font" "$BLUE"
  brew tap homebrew/cask-fonts && brew_install font-lilex-nerd-font
  cp zsh/starship.toml ~/.config/starship.toml

  # Init alacritty
  prompt "Installing ${BOLD_GREEN}alacritty"
  brew_install alacritty
  [[ -z $(infocmp alacritty >/dev/null 2>&1) ]] || sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
  cp -R alacritty ~/.config

  # Init vim
  prompt "Initializing ${BOLD_GREEN}vim"
  cp vim/.vimrc ~/.vimrc

  # Init zsh
  prompt "Initializing ${BOLD_GREEN}zsh"
  cp zsh/.zshrc ~/.zshrc
}

init_utils
init_zsh
echo -e "\nRun \`source ~/.zshrc\` to apply changes!"
