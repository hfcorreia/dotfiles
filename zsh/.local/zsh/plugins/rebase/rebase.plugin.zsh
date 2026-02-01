#!/bin/zsh

function rebase() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
  fi
  if git show-ref --verify --quiet refs/heads/main; then
    echo "The 'main' branch exists."
    git stash && git co main && git pull origin main && git co - && git rebase - && git stash pop
  fi

  if git show-ref --verify --quiet refs/heads/master; then
    echo "The 'master' branch exists."
    git stash && git co master && git pull origin master && git co - && git rebase - && git stash pop
  fi
}
