compdef _dev dev

autoload function dev() {
  [ "$#" -eq 0 ] && cd $HOME/Development

  cd "$HOME/Development/$1"
}

function _dev {
  local dirs=$(find $HOME/Development -mindepth 1  -maxdepth 1 -type d -execdir basename '{}' ';')

  _arguments  \
    "1: :($dirs)" \
    "*::arg:->args"
}
