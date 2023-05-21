#!/bin/bash

brew_install() {
  brew list "$1" >/dev/null || brew install "$1"
}

init_utils() {
  declare -ar formulae=(exa colima tmux)
  echo "Initializing utils [${formulae[*]}]..."
  for formula in "${formulae[@]}"; do
    brew_install "$formula"
  done
  echo -e "DONE!\n"
}

init_zsh() {
  # Init oh-my-zsh
  echo "Initializing oh-my-zsh..."
  if [[ ! -d $HOME/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  echo -e "DONE!\n"

  # Init Starship
  echo "Initializing starship..."
  brew_install starship
  brew tap homebrew/cask-fonts && brew_install font-lilex-nerd-font
  cp zsh/starship.toml ~/.config/starship.toml
  echo -e "DONE!\n"

  # Init alacritty
  echo "Initializing alacritty..."
  brew_install alacritty
  if [[ -n $(infocmp alacritty >/dev/null 2>&1) ]]; then
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
  fi
  cp -R alacritty ~/.config
  echo -e "DONE!\n"

  # Init vim
  echo "Initializing vim..."
  cp vim/.vimrc ~/.vimrc
  echo -e "DONE!\n"

  # Init zsh
  echo "Initializing zsh..."
  cp zsh/.zshrc ~/.zshrc
  echo "DONE!"
}

init_utils
init_zsh
echo "Run \`source ~/.zshrc\` to apply changes!"
