#!/bin/zsh

function rebase() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
    return 1
  fi

  local default_branch
  if git show-ref --verify --quiet refs/heads/main; then
    default_branch="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    default_branch="master"
  else
    echo "Error: Neither 'main' nor 'master' branch found."
    return 1
  fi

  # In a worktree we can't checkout branches — fetch and rebase directly
  if [[ "$(git rev-parse --git-dir)" != "$(git rev-parse --git-common-dir)" ]]; then
    git fetch origin "$default_branch" && git rebase "origin/${default_branch}"
  else
    git stash && git co "$default_branch" && git pull origin "$default_branch" && git co - && git rebase - && git stash pop
  fi
}
