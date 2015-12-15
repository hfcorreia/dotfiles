# Git aliases based on the current branch
alias gpush='git push origin $(git symbolic-ref --short -q HEAD)'
alias gpull='git pull origin $(git symbolic-ref --short -q HEAD)'
alias gstat='git st'

# Quick change to known branches
alias gmaster='git checkout master && gpull'
alias gstaging='git checkout staging && gpull'

# Quickly create a new branch
alias gcreate='git checkout -b '
