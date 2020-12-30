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
  common-aliases
  docker
  git
  node
  npm
  tmux
  wd
)

## THEME
ZSH_THEME="powerlevel10k/powerlevel10k"
## INIT
source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# SSH
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "Loading SSH identities..." && ssh-add

# PROGRAM SETTINGS/OVERRIDES
## OPENSSL
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
### export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
### export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
### export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

## IMAGEMAGICK (HOMEBREW)
# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
### export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
### export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
### export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"

## MYSQL (HOMEBREW)
### MYSQL (5.6)
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/mysql@5.6/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.6/include"
# export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

### MYSQL (5.7)
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

## QT (HOMEBREW)
# export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

## JAVA
[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

## NODE/JS/TS
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## PYTHON
export PATH="$HOME/.pyenv/bin:$PATH"
export PYTHON_CONFIGURE_OPTS="--enable-shared"
eval "$(pyenv init -)"

# RUBY
export PATH="$HOME/.rbenv/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--disable-dtrace --with-readline-dir=$(brew --prefix readline) --with-openssl-dir=$(brew --prefix openssl@1.1)"
eval "$(rbenv init -)"

# AWS CLI
## V1
# export PATH="/usr/local/opt/awscli@1/bin:$PATH"

## assume-role
alias assume-role='function(){eval $(command assume-role $@);}'

## icu4c
### export PATH="/usr/local/opt/icu4c/sbin:$PATH"
### export LDFLAGS="-L/usr/local/opt/icu4c/lib"
### export CPPFLAGS="-I/usr/local/opt/icu4c/include"
### export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

## libffi
### export LDFLAGS="-L/usr/local/opt/libffi/lib"
### export CPPFLAGS="-I/usr/local/opt/libffi/include"
### export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

# USER
## ENV
export EDITOR='vim'
export VISUAL=$EDITOR

## ALIASES

## TERMINAL
alias c="clear"

## SYSTEM ADMINISTRATION
alias aptUpgrade='sudo apt update && sudo apt upgrade -y'
alias brewme='brew update && brew upgrade && brew cleanup'
alias be='bundle exec'

## FUZZY FINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## PIPE HIGHLIGHTING (requires 'highlight' be installed)
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'
alias cath="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"

## FUNCTIONS
## calc(): A command line calculator using bc
calc() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# ADDITIONAL PROGRAM SETTINGS AND CONFIGURATION

## POST-INITIALIZATION
stty -ixon # Prevent terminal freezing
setopt extended_glob # Enables extended globbing (expansion) features
export PATH="/usr/local/opt/curl/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
