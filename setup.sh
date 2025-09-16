#!/bin/bash

echo "Cloning dotfiles to .dotfiles"
git clone git@github.com:hfcorreia/dotfiles.git ~/.dotfiles

echo "Setting up path to stow"
export PATH=/opt/homebrew/bin:$PATH

echo "Running brew bundle"
cd ~/.dotfiles
brew bundle

echo "Create local zshrc"
touch ~/.zshrc.local

echo "Install bat theme"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

echo "Run stow"
stow -v --restow */
