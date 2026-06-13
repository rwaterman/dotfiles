# Helpers
is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux* ]]; }
have() { command -v "$1" >/dev/null 2>&1; }
source_if_exists() { [ -f "$1" ] && source "$1"; }

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ZSH_TMUX_AUTOSTART="false"
ZSH_TMUX_AUTOCONNECT="false"

plugins=(
  aws
  docker
  docker-compose
  git
  node
  npm
  ngrok
  pipenv
  python
  terraform
  tmux
  wd
)

source "$ZSH/oh-my-zsh.sh"

# Program Settings / Overrides
if is_macos; then
  # Get CPU brand string (e.g. "Apple M3 Max")
  local CHIP_NAME
  CHIP_NAME="$(sysctl -n machdep.cpu.brand_string 2>/dev/null)"

  # Default optimization
  local CPU_FLAG="-O3"

  # Normalize chip name (avoid case-sensitivity issues)
  CHIP_NAME="${CHIP_NAME:u}"

  # Match Apple Silicon generation
  case "$CHIP_NAME" in
    *"M1"*) CPU_FLAG="-O3 -mcpu=apple-m1" ;;
    *"M2"*) CPU_FLAG="-O3 -mcpu=apple-m2" ;;
    *"M3"*) CPU_FLAG="-O3 -mcpu=apple-m3" ;;
    *"M4"*) CPU_FLAG="-O3 -mcpu=apple-m4" ;;
    *"M5"*) CPU_FLAG="-O3 -mcpu=apple-m4" ;; # TODO: Check back later. No apple-m5 is available yet.
    *)      CPU_FLAG="-O3 -mcpu=native" ;;  # fallback for Intel
  esac

  export CFLAGS="${CFLAGS:-$CPU_FLAG}"
  export CXXFLAGS="${CXXFLAGS:-$CPU_FLAG}"

elif is_linux; then
  export CFLAGS="${CFLAGS:--O3 -march=native}"
  export CXXFLAGS="${CXXFLAGS:--O3 -march=native}"
fi

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# Shell Behavior
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# Completion
autoload -Uz compinit # Load completion system
autoload -U +X bashcompinit && bashcompinit # Bash completion emulation (for tools that need it)
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump" # Initialize completion with cached metadata file
zstyle ':completion:*' menu select # Enable interactive completion menu selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Make completion case-insensitive -- Example: "doc" can complete to "Documents"

# Python / pyenv
export PYTHON_CONFIGURE_OPTS="--enable-shared"
have pyenv && eval "$(pyenv init -)"
have pyenv && eval "$(pyenv init --path)"

# Aliases
source_if_exists "$HOME/aliases.zsh"

# FZF
# macOS / Homebrew (Apple Silicon)
if [[ -f $HOME/brew/opt/fzf/shell/key-bindings.zsh ]]; then
  source $HOME/brew/opt/fzf/shell/key-bindings.zsh
  source $HOME/brew/opt/fzf/shell/completion.zsh
fi

# Arch
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# Ubuntu
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
fi

source_if_exists "$HOME/fzf.zsh"

# Pagers
if have bat; then
  export MANPAGER="bat -l man -p"
fi

if have highlight; then
  export LESSOPEN="| $(command -v highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
  export LESS=" -R"
fi

#### Functions #################################################################
calc() {
  local calc="${*@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

#### Misc Shell Tweaks #########################################################
stty -ixon
setopt extended_glob

#### Shell/Prompt tooling (guarded) ############################################
eval "$(oh-my-posh init zsh)"

# zoxide
have zoxide && eval "$(zoxide init zsh)"

# ATUIN (guarded)
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
have atuin && eval "$(atuin init zsh --disable-up-arrow)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

