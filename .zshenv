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

# AWS
case "$USER" in
  rick-sroa) export AWS_REGION="us-east-1" ;;
  *)         export AWS_REGION="us-west-2" ;;
esac

# TLS: Needed for running some Python tools locally 
export SSL_CERT_FILE="/etc/ssl/cert.pem"

# PATH
export PATH="$HOME/brew/bin:$HOME/brew/sbin:$HOME/bin:$HOME/.local/bin:$HOME/.pyenv/bin:$HOME/brew/opt/curl/bin:$PATH"
