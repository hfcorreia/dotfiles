function dsh() {
  docker exec -it $1 bash
}

autoload dsh

alias dps='docker ps'
alias dnets='docker network ls'
alias ds='docker stop'
alias dsall='docker stop $(docker ps -q)'
