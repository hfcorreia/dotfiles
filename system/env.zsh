#!/bin/zsh

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Use vim as default editor
export EDITOR="nvim"

# Hookup direnv
eval "$(direnv hook zsh)"

# Startup dinghy
eval "$(dinghy env)"
