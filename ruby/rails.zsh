autoload function krails() {
  [ "$#" -eq 0 ] && return 1

  local container=$(kubectl get pods --namespace=development --selector=app=$1 | sed -n 2p | awk '{print $1}')

  if [ "$#" -eq 2 ]; then
    kubectl --namespace development exec -it $container -c $2 bundle exec rails c

    return 0
  fi

  kubectl --namespace development exec -it $container bundle exec rails c
}

