#!/bin/bash

echo "Cloning dotfiles to .dotfiles"
git clone git@github.com:hfcorreia/dotfiles.git ~/.dotfiles

echo "Running brew bundle"
cd ~/.dotfiles
brew bundle
