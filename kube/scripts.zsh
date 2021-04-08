#!/bin/zsh

autolaod function kex() {
  NAMESPACE="development"
  vared -p $'  \033[1mNamespace:\033[0m ' NAMESPACE
  local POD=$(kubectl get pods -n $NAMESPACE --no-headers | fzf-tmux --reverse --multi | awk -F'[ ]' '{print $1}')
  local CONTAINER=$(kubectl get pods -n $NAMESPACE $POD -o jsonpath='{.spec.containers[*].name}' | tr ' ' '\n' | fzf-tmux --reverse --multi | awk -F'[ ]' '{print $1}')
  local CONTEXT=$(kubectl config current-context | tr -d '\n')
  if [[ $POD != '' ]]; then
    echo  "\n  \033[1mContext:\033[0m" $CONTEXT
    echo  "  \033[1mNamespace:\033[0m" $NAMESPACE
    echo  "  \033[1mPod:\033[0m" $POD
    echo  "  \033[1mContainer:\033[0m" $CONTAINER
    OPTIONS="-it"
    vared -p $'  \033[1mOptions:\033[0m ' OPTIONS
    if [[ $@ == '' ]]; then
                CMD="bash"
                vared -p $'  \033[1mCommand:\033[0m ' CMD
    else
                CMD="$@"
    fi
    echo ''
    print -s kex "$@"
    print -s kubectl exec $OPTIONS -n $NAMESPACE $POD -c $CONTAINER $CMD
    zsh -c "kubectl exec $OPTIONS -n $NAMESPACE $POD -c $CONTAINER $CMD"
  fi
}
