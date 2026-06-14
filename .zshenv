# Language
export LANG='en_US.UTF-8'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
[[ -d "$XDG_STATE_HOME/zsh" ]] || mkdir -p "$XDG_STATE_HOME/zsh"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Display
export COLORTERM=truecolor

# GPG
export GPG_TTY=$(tty)

# PATH
export PATH="$HOME/brew/bin:$HOME/bin:$HOME/.local/bin:$HOME/.pyenv/bin:$PATH"

