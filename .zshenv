# Language
export LANG='en_US.UTF-8'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Display
export COLORTERM=truecolor

# ---------- GPG ----------
export GPG_TTY=$(tty)

# ---------- PATH ----------
# Personal binaries/scripts
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/brew/bin:$HOME/.pyenv/bin:$PATH"

