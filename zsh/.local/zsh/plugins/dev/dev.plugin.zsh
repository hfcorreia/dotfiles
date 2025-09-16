#!/bin/zsh

compdef _dev dev

function dev() {
  [ "$#" -eq 0 ] && cd $HOME/dev

  cd "$HOME/dev/$1"
}

function _dev {
  local dirs=$(find $HOME/dev -mindepth 1  -maxdepth 1 -type d -execdir basename '{}' ';')

  _arguments  \
    "1: :($dirs)" \
    "*::arg:->args"
}
