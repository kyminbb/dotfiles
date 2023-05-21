#!/bin/bash

readonly NC="\033[0m"
readonly BOLD_GREEN="\033[1;32m"
readonly BOLD_WHITE="\033[1;37m"

prompt() {
  echo -e "${BOLD_GREEN}==>${BOLD_WHITE} $1${NC}"
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
  if [[ ! -d $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  # Init Starship
  prompt "Installing ${BOLD_GREEN}starship"
  brew_install starship
  prompt "Installing ${BOLD_GREEN}font-lilex-nerd-font"
  brew tap homebrew/cask-fonts && brew_install font-lilex-nerd-font
  cp zsh/starship.toml ~/.config/starship.toml

  # Init alacritty
  prompt "Installing ${BOLD_GREEN}alacritty"
  brew_install alacritty
  if [[ -n $(infocmp alacritty >/dev/null 2>&1) ]]; then
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
  fi
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
