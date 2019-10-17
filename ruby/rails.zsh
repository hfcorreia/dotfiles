autoload function krails() {
  readonly app=${1:?"app name has to be specified"}

  local container=$(kubectl get pods --namespace=development --selector=app=$app | sed -n 2p | awk '{print $1}')

  if [ "$#" -eq 2 ]; then
    kubectl --namespace development exec -it $container -c $2 -- bundle exec rails c

    return 0
  fi

  kubectl --namespace development exec -it $container -- bundle exec rails c
}

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
