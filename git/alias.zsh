#!/bin/zsh

# Git aliases based on the current branch
alias gpush='git push origin $(git symbolic-ref --short -q HEAD)'
alias gpull='git pull origin $(git symbolic-ref --short -q HEAD)'

# Quickly set upstream
alias gupstream='git branch --set-upstream-to=origin/$(git symbolic-ref --short -q HEAD) $(git symbolic-ref --short -q HEAD)'

# Quick toggle branch
alias g-='git co -'

alias amend!='git commit -a --amend --no-edit && git push --force-with-lease'

alias glog='git --no-pager show -s --format=%B HEAD | pbcopy'

alias grebase!='git co master && git pull origin master && git co - && git rebase -'
