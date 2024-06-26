# @author Rick Waterman
# @copyright MIT License
# .zshrc

# ENV - CORE
export LANG='en_US.UTF-8' # Set system language to US English with UTF-8 character encoding
export TERM='xterm-256color' # Turn on 256 colors (as opposed to 16) in the terminal

# OH MY ZSH
## CORE
export ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ZSH_TMUX_AUTOSTART="false"
ZSH_TMUX_AUTOCONNECT="false"

## PLUGINS
plugins=(
  aws
  common-aliases
  docker
  docker-compose
  git
  node
  npm
  terraform
  tmux
  wd
  yarn
)

#

## THEME
ZSH_THEME="powerlevel10k/powerlevel10k"
## INIT
source $ZSH/oh-my-zsh.sh
export PATH="$HOME/bin:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# SSH

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# PROGRAM SETTINGS/OVERRIDES
## JAVA
export JAVA_HOME=$(/usr/libexec/java_home)

## Jabba (Java Switcher)
[ -s "/opt/homebrew/opt/jabba/share/jabba/jabba.sh" ] && . "/opt/homebrew/opt/jabba/share/jabba/jabba.sh"

## NODEJS/TS
### ENV
export NODE_OPTIONS=--max-old-space-size=16384

### NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## PYTHON
export PATH="$HOME/.pyenv/bin:$PATH"
export PYTHON_CONFIGURE_OPTS="--enable-shared"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

# USER
## ENV
export EDITOR='nvim'
export VISUAL=$EDITOR
alias nv='nvim'

## ALIASES

# TERRAFORM
alias tfplan='terraform plan -out="tfplan"'
alias tfapply='terraform apply "tfplan"'
alias tfdeploy='terraform fmt && terraform validate && tfplan && tfapply'
alias tfdestroy='terraform plan -destroy -out="tfplan" && tfapply'
alias tffv="terraform fmt && terraform validate"

# NET
alias whatismyip='curl ifconfig.me'
alias pinggoogle="ping google.com -C 10"

# DOCKER
alias boomshakalaka='find . -name "*.d.ts" -not -path "./node_modules/*" -print -delete && find . -name "node_modules" -type d -prune -print -exec rm -rfv "{}" + && find . -name ".idea" -type d -prune -print -exec rm -rfv "{}" +'
alias shazam='
  docker ps -a -q | xargs -r docker rm -f && 
  docker volume ls -q | xargs -r docker volume rm &&
  docker network ls --format "{{.Name}}" | grep -vE "^(bridge|host|none)$" | xargs -r docker network rm &&
  docker images -q | xargs -r docker rmi -f
'
# GIT
alias git_branch_cleanup="git branch --no-color | fzf -m | xargs -I {} git branch -D '{}'"

# NPM
alias npmr='npm run'
alias npmb='npm run build'
alias npmbf='npm run build:force'
alias npml='npm run lint'
alias npmlf='npm run lint:fix'
alias npmt='npm run test'
alias npmw='npm run watch'
alias slsol='sls offline -s local'
alias slssol='sls offline start -s local'
# alias rollup='npm run rollup'
alias codegen='npm run codegen'
alias rm_d_ts="find . -name '*.d.ts' -not -path './node_modules/*' -delete"
alias rm_node_modules="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias npmreset='npm ci && npm run build:force && npm run lint:fix'
alias npmcipo='npm ci --prefer-offline'

## TERMINAL
alias c="clear"

## SYSTEM ADMINISTRATION
alias aptUpgrade='sudo apt update && sudo apt upgrade -y'
alias brewme='brew update && brew upgrade && brew cleanup'

## FUZZY FINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## PIPE HIGHLIGHTING (requires 'highlight' be installed)
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'
alias cath="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"
alias cht="$HOME/bin/cht.sh"

## FUNCTIONS
## calc(): A command line calculator using bc
calc() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# ADDITIONAL PROGRAM SETTINGS AND CONFIGURATION

## MISC
stty -ixon # Prevent terminal freezing
setopt extended_glob # Enables extended globbing (expansion) features
export PATH="/usr/local/opt/curl/bin:$PATH"

## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit

export HOMEBREW_NO_ENV_HINTS=true

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

eval "$(zoxide init zsh)"


## AWS
export AWS_PAGER=""

## TMUX
alias tm='tmux new-session -A -s alpha'

