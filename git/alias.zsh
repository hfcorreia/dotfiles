# Git aliases based on the current branch
alias gpush='git push origin $(git symbolic-ref --short -q HEAD)'
alias gpull='git pull origin $(git symbolic-ref --short -q HEAD)'

# Quick change to known branches
alias gmaster='git checkout master && gpull'
alias gstaging='git checkout staging && gpull'

# Quickly create a new branch
alias gcreate='gmaster && git checkout -b '

# Quickly set upstream
alias gupstream='git branch --set-upstream-to=origin/$(git symbolic-ref --short -q HEAD) $(git symbolic-ref --short -q HEAD)'

# Quick merges
alias gmerge='git merge '
