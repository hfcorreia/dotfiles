# Setup Path for brew
export PATH="/opt/homebrew/bin:$PATH"

# Setup path for ZPLUG
export ZPLUG_HOME=/opt/homebrew/opt/zplug

# Setup Brew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Load zplug
source $ZPLUG_HOME/init.zsh

zplug "agkozak/zsh-z"

# oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh

# pretzo
zplug "modules/completion", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/environment", from:prezto
zplug "modules/history", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/tmux", from:prezto
zplug "modules/utility",  from:prezto

zplug "wfxr/forgit"

zplug "~/.local/zsh/plugins/dev/", from:local
zplug "~/.local/zsh/plugins/rebase/", from:local

zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:2, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

# Theme
zplug "themes/sorin", from:oh-my-zsh, as:theme

#################################
# zstyle config

## coloring
zstyle ':prezto:module:utility:ls'    color 'yes'

## enable safe operations
zstyle ':prezto:module:utility' safe-ops 'yes'

## always start the zsh in tmux
zstyle ':prezto:module:tmux:auto-start' local  'yes'
zstyle ':prezto:module:tmux:auto-start' remote 'yes'

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'vi'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Install plugins if needed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load the plugins
zplug load

autoload -U zmv
#################################
# Setup ZSH History Substring
#################################
if zplug check zsh-users/zsh-history-substring-search; then
    bindkey '^[OA' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
fi

if zplug check zsh-users/zsh-autosuggestions; then
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-substring-search-up history-substring-search-down)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS=("${(@)ZSH_AUTOSUGGEST_CLEAR_WIDGETS:#(up|down)-line-or-history}")
fi
#################################
# Setup fzf
#################################
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=20
export FZF_DEFAULT_OPTS='--height 20% --layout=reverse'

#################################
# Setup direnv
#################################
eval "$(direnv hook zsh)"

#################################
# Aliases
#################################

## System
alias c="clear"
alias e="exit"

## Git
alias gpull='git pull origin $(git symbolic-ref --short -q HEAD)'
alias gpush='git push origin $(git symbolic-ref --short -q HEAD)'

## Vim
alias vi='nvim'
alias vim='nvim'

## Bat
alias cat="bat"

#################################
# Path
#################################

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Source ASDF
. $(brew --prefix asdf)/libexec/asdf.sh

#################################
# Global Env Vars
#################################
if [[ -z "$EDITOR" ]]; then
  export EDITOR='nvim'
fi
if [[ -z "$VISUAL" ]]; then
  export VISUAL='nvim'
fi
if [[ -z "$PAGER" ]]; then
  export PAGER='less'
fi
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#################################
# Git
#################################
function fixup! () {
  git ls -n 20 | fzf | cut -d " " -f 1 | xargs git commit --no-verify --fixup
}

#################################
# Bat
#################################
export BAT_THEME="Catppuccin-mocha"

