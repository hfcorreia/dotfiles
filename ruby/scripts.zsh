#!/bin/zsh

autoload function specs() {
  if [ "$#" -eq 0 ]; then
    bundle exec rspec

    return 0
  fi

  if [ "$#" -eq 2 ]; then
    RAILS_ENV=$1 bundle exec rspec $2

    return 0
  fi


  bundle exec rspec $1
}

autoload function dbrails() {
  if [ "$#" -eq 1 ]; then
    RAILS_ENV=$1 bundle exec rails db:drop db:create db:migrate

    return 0
  fi

  bundle exec rails db:drop db:create db:migrate
}
