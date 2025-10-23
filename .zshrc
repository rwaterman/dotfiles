# @author Rick Waterman
# @copyright MIT License
# .zshrc (OS-aware)

#### Helpers ###################################################################
is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux* ]]; }
have() { command -v "$1" >/dev/null 2>&1; }
source_if_exists() { [ -f "$1" ] && source "$1"; }
prepend_path() { [ -d "$1" ] && PATH="$1:$PATH"; }

#### ENV - CORE ################################################################
export LANG='en_US.UTF-8'
export TERM='xterm-256color'

# XDG base
export XDG_CONFIG_HOME="$HOME/.config"

#### OH MY ZSH #################################################################
export PATH="$PATH:$HOME/brew/bin:$HOME/.local/bin"
export ZSH="$HOME/.oh-my-zsh"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ZSH_TMUX_AUTOSTART="false"
ZSH_TMUX_AUTOCONNECT="false"

plugins=(
  aws
  common-aliases
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

#### PATH Overrides (OS-aware) ##################################################
# Coreutils (macOS Homebrew GNU paths)
if is_macos; then
  prepend_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
  # Prefer Homebrew curl (Apple Silicon default)
  prepend_path "/opt/homebrew/opt/curl/bin"
  # Intel mac fallback (if present)
  prepend_path "/usr/local/opt/curl/bin"
fi

# User bin
prepend_path "$HOME/bin"


#### PROGRAM SETTINGS / OVERRIDES ##############################################
# CLANG/LLVM flags (macOS Apple Silicon only)
if is_macos; then
  export CFLAGS="-O3 -mcpu=apple-m3"
  export CXXFLAGS="-O3 -mcpu=apple-m3"
else
  # Reasonable default elsewhere
  export CFLAGS="${CFLAGS:--O3 -march=native}"
  export CXXFLAGS="${CXXFLAGS:--O3 -march=native}"
fi

# JAVA (macOS java_home helper)
if is_macos && have /usr/libexec/java_home; then
  export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
fi
# On Linux, prefer jenv/packaged Java if present
if is_linux && [ -z "$JAVA_HOME" ]; then
  for c in /usr/lib/jvm/default /usr/lib/jvm/java-*/; do
    [ -d "$c" ] && { export JAVA_HOME="$c"; break; }
  done
fi

# Node / TypeScript
export NODE_OPTIONS="--max-old-space-size=16384 --no-experimental-detect-module --no-experimental-require-module"
export JSII_SILENCE_WARNING_UNTESTED_NODE_VERSION=true

# NVM
export NVM_DIR="$HOME/.nvm"
source_if_exists "$NVM_DIR/nvm.sh"
source_if_exists "$NVM_DIR/bash_completion"

# Python / pyenv
prepend_path "$HOME/.pyenv/bin"
export PYTHON_CONFIGURE_OPTS="--enable-shared"
have pyenv && eval "$(pyenv init -)"
have pyenv && eval "$(pyenv init --path)"

#### USER PREFS #################################################################
export EDITOR='nvim'
export VISUAL="$EDITOR"

# Quick config
alias wez_config='nvim $HOME/.wezterm.lua'
alias zsh_config='nvim $HOME/.zshrc'
alias nvim_config='nvim $XDG_CONFIG_HOME/nvim/init.lua'

# Editors
alias v='nvim'

# Git
alias git_branch_cleanup="git branch --no-color | fzf -m | xargs -I {} git branch -D '{}'"
alias gh_run_watch='gh run watch --compact && ntfy pub $NTFY_TOPIC "Success" || ntfy pub $NTFY_TOPIC "Failed"'

# Tmux
alias tmg='tmux new-session -A -s main'
alias tmt='tmux new-session -A -s secondary'

# Terraform
alias tffv="terraform fmt && terraform validate"
alias tfplan='terraform plan -out="tfplan"'
alias tfapply='terraform apply "tfplan"'
alias tfdeploy='tffv && tfplan && tfapply'
alias tfdestroy='tffv && terraform plan -destroy -out="tfplan" && tfapply'

# Internet
alias whatismyip='curl ifconfig.me'
alias check_ping="ping google.com -c 10"

#### Docker completion (path safe) #############################################
setopt appendhistory
setopt auto_cd
fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
compinit

# Docker nuker (careful!)
alias rm_docker_all='
  docker ps -a -q | xargs -r docker rm -f &&
  docker volume ls -q | xargs -r docker volume rm &&
  docker network ls --format "{{.Name}}" | grep -vE "^(bridge|host|none)$" | xargs -r docker network rm &&
  docker images -q | xargs -r docker rmi -f
'

# NPM / Node
alias npmr='npm run'
alias npmb='npm run build'
alias npmbf='npm run build:force'
alias npml='npm run lint'
alias npmlf='npm run lint:fix'
alias npmt='npm run test'
alias npmw='npm run watch'
alias npmreset='npm ci && npm run build:force && npm run lint:fix'
alias npmcipo='npm ci --prefer-offline'
alias slsol='sls offline -s local'
alias slssol='sls offline start -s local'
alias codegen='npm run codegen'
alias rm_d_ts_files="find . -name '*.d.ts' -not -path './node_modules/*' -delete"
alias rm_node_modules_dirs="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias rm_idea_dirs='find . -name ".idea" -type d -prune -print -exec rm -rfv "{}" +'

# Terminal
alias c="clear"

#### System Admin (OS-aware) ###################################################
# Debian/Ubuntu
if is_linux && have apt; then
  alias aptUpgrade='sudo apt update && sudo apt upgrade -y'
fi
# Arch
if is_linux && have pacman; then
  alias pacme='sudo pacman -Syu --noconfirm'
fi
# Homebrew (macOS or Linuxbrew)
if have brew; then
  alias brewme='brew update && brew upgrade && brew cleanup'
fi

#### FZF #######################################################################
source_if_exists "$HOME/.fzf.zsh"

#### Pager highlighting (requires 'highlight') #################################
if have highlight; then
  export LESSOPEN="| $(command -v highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
  export LESS=" -R"
  alias less='less -m -N -g -i -J --line-numbers --underline-special'
  alias more='less'
  alias cath="highlight \$1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"
fi
alias cht="$HOME/bin/cht.sh"

#### Functions #################################################################
calc() {
  local calc="${*@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

run_with_timing() {
  local start_time end_time duration
  start_time=$(date +%s)
  "$@"; local cmd_status=$?
  end_time=$(date +%s)
  duration=$((end_time - start_time))
  echo "Command: $*"
  echo "Execution time: ${duration}s"
  return $cmd_status
}

#### Misc Shell Tweaks #########################################################
stty -ixon
setopt extended_glob

#### Shell/Prompt tooling (guarded) ############################################
eval "$(oh-my-posh init zsh)"

# Bash completion emulation (for tools that need it)
autoload -U +X bashcompinit && bashcompinit

# Homebrew JAVA bin on macOS
if is_macos; then
  prepend_path "/opt/homebrew/opt/openjdk/bin"
fi

# ngrok completion
if have ngrok; then
  eval "$(ngrok completion)"
fi

# zoxide
have zoxide && eval "$(zoxide init zsh)"

# AWS
export AWS_PAGER=""

# juliaup (left disabled as in original)
# path=("$HOME/.juliaup/bin" $path); export PATH

# ATUIN (guarded)
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
have atuin && eval "$(atuin init zsh --disable-up-arrow)"

