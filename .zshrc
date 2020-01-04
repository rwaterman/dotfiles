# @author Rick Waterman
# @copyright MIT License
# .zshrc

## ENV - CORE
export LANG='en_US.UTF-8' # Set system language to US English with UTF-8 character encoding
export TERM='screen-256color' # Turn on 256 colors (as opposed to 16) in the terminal

### OH MY ZSH
export ZSH=$HOME/.oh-my-zsh
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"
plugins=(
  bundler
  common-aliases
  docker
  git
  node
  npm
  python
  ruby
  tmux
  wd
)
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs history)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
source $ZSH/oh-my-zsh.sh

# SSH
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

## JAVA
[ -s "/home/rick/.jabba/jabba.sh" ] && source "/home/rick/.jabba/jabba.sh"

## NODE/JS/TS
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## PYTHON
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

## RUBY
export PATH="$HOME/.rbenv/bin:$PATH"

## RUST
export PATH="$HOME/.cargo/bin:$PATH"

# USER
## ENV
export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR='vim'
export VISUAL=$EDITOR
export AWS_PROFILE=rick

## ALIASES

### TERMINAL
alias c="clear"

## SYSTEM ADMINISTRATION
alias aptUpgrade='sudo apt update && sudo apt upgrade -y'
alias brewme='brew update && brew upgrade && brew cleanup'

## FUNCTIONS
## calc(): A command line calculator using bc
calc() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# ADDITIONAL PROGRAM SETTINGS AND CONFIGURATION

## PATHs
# export PATH="/usr/local/opt/qt@5.5/bin:$PATH" TODO
# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH" TODO
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH" TODO

## FUZZY FINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## PIPE HIGHLIGHTING (requires 'highlight' be installed)
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'
alias cath="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"


## POST-INITIALIZATION
stty -ixon # Prevent terminal freezing
setopt extended_glob # Enables extended globbing (expansion) features
