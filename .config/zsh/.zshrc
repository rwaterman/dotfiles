# Functions and helpers (sourced first: used throughout this file and other modules)
source "$ZDOTDIR/functions.zsh"

# Oh-My-Zsh
export ZSH="$ZDOTDIR/ohmyzsh"
ZSH_THEME=""
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"

plugins=(
  aws
  docker
  docker-compose
  git
  history-substring-search
  node
  npm
  pipenv
  python
  terraform
  tmux
  wd
)

source "$ZSH/oh-my-zsh.sh"


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

# Completion (OMZ handles compinit; ZSH_COMPDUMP path set in the OMZ block above)
autoload -U +X bashcompinit && bashcompinit # Bash completion emulation (for tools that need it)
zstyle ':completion:*' menu select # Enable interactive completion menu selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Make completion case-insensitive -- Example: "doc" can complete to "Documents"

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

# Python / pyenv
export PYTHON_CONFIGURE_OPTS="--enable-shared"
have pyenv && eval "$(pyenv init -)"
have pyenv && eval "$(pyenv init --path)"

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

# Pagers
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="bat -l man -p"
elif command -v batcat >/dev/null 2>&1; then
  export MANPAGER="batcat -l man -p"
fi

# Syntax/Languages
if have highlight; then
  export LESSOPEN="| $(command -v highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
  export LESS=" -R"
fi

# Modular Config Files

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

#### Misc Shell Tweaks #########################################################
stty -ixon
setopt extended_glob

export PATH="$HOME/brew/bin:$PATH"

# zoxide
have zoxide && eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
