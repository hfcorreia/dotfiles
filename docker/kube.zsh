autoload function kbash() {
  readonly app=${1:?"app name has to be specified"}

  local container=$(kubectl get pods --namespace=development --selector=app=$app --field-selector=status.phase=Running | sed -n 2p | awk '{print $1}')

  if [ "$#" -eq 2 ]; then
    kubectl --namespace development exec -it $container -c $2 -- bash

    return 0
  fi

  kubectl --namespace development exec -it $container -- bash
}
