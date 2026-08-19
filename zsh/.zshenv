# Sourced by every zsh invocation (interactive, non-interactive, login or not) —
# unlike .zshrc, this reaches non-interactive shells such as tmux's run-shell/popup
# scripts, which is required for tmux plugins that shell out to find binaries.

# Machine/work-specific PATH and env vars (gitignored, not tracked in dotfiles)
[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
