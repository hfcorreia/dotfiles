#!/bin/bash

echo "Install dev tools on MacOS"
xcode-select --install

echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Cloning dotfiles to .dotfiles"
git clone git@github.com:hfcorreia/dotfiles.git ~/.dotfiles

echo "Running brew bundle"
cd ~/.dotfiles
brew bundle
