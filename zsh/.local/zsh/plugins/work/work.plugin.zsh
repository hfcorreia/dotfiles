#!/bin/zsh

compdef _work work

function work() {
  [ "$#" -eq 0 ] && cd $HOME/work

  cd "$HOME/work/$1"
}

function _work {
  local dirs=$(find $HOME/work -mindepth 1  -maxdepth 1 -type d -execdir basename '{}' ';')

  _arguments  \
    "1: :($dirs)" \
    "*::arg:->args"
}
