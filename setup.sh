#!/bin/bash

echo "Cloning dotfiles to .dotfiles"
git clone git@github.com:hfcorreia/dotfiles.git ~/.dotfiles

echo "Running brew bundle"
cd ~/.dotfiles
brew bundle

echo "Setting up path to stow"
export PATH=/opt/homebrew/bin:$PATH

echo "Run stow"
stow -v --restow */
