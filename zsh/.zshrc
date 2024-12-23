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
  ngrok
  pipenv
  poetry
  python
  terraform
  tmux
  wd
  nvm
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

## Jabba (Java Switcher) - Project looks abandoned, just using OS package manager or jenv
# [ -s "/opt/homebrew/opt/jabba/share/jabba/jabba.sh" ] && . "/opt/homebrew/opt/jabba/share/jabba/jabba.sh"

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
alias tffv="terraform fmt && terraform validate"
alias tfplan='terraform plan -out="tfplan"'
alias tfapply='terraform apply "tfplan"'
alias tfdeploy='tffv && tfplan && tfapply'
alias tfdestroy='tffv && terraform plan -destroy -out="tfplan" && tfapply'

# NET
alias whatismyip='curl ifconfig.me'
alias check_ping="ping google.com -C 10"

# DOCKER
alias rm_docker_resources='
  docker ps -a -q | xargs -r docker rm -f && 
  docker volume ls -q | xargs -r docker volume rm &&
  docker network ls --format "{{.Name}}" | grep -vE "^(bridge|host|none)$" | xargs -r docker network rm &&
  docker images -q | xargs -r docker rmi -f
'
# GIT
alias git_branch_cleanup="git branch --no-color | fzf -m | xargs -I {} git branch -D '{}'"

# NPM/NODEJS
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

run_with_timing() {
    # Start time
    start_time=$(date +%s)

    # Run the command and capture its output
    "$@"
    cmd_status=$?

    # End time
    end_time=$(date +%s)

    # Calculate the duration
    duration=$((end_time - start_time))

    # Print the command and the duration
    echo "Command: $@"
    echo "Execution time: ${duration}s"

    # Return the status of the command
    return $cmd_status
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
alias tmg='tmux new-session -A -s gamma' # Primary sessions name
alias tmt='tmux new-session -A -s tau'  # Secondary sessions name

# bun completions
[ -s "/Users/rick/.bun/_bun" ] && source "/Users/rick/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# >>> juliaup initialize >>>
# !! Contents within this block are managed by juliaup !!
# path=('/Users/rick/.juliaup/bin' $path)
# export PATH
# <<< juliaup initialize <<<

setopt appendhistory
setopt auto_cd
