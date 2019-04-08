# @author Rick Waterman
# @copyright MIT License
# .zshrc

# STARTUP INITIALIZATION
export LANG='en_US.UTF-8' # Set system language to US English with UTF-8 character encoding
export TERM='screen-256color' # Turn on 256 colors (as opposed to 16) in the terminal
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
PATH=$PATH:$HOME/bin:$HOME/go/bin
## Program path modifications
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
setopt extended_glob # Enables extended globbing (expansion) features
## oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs history)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"
stty -ixon # Prevent terminal freezing
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
source $ZSH/oh-my-zsh.sh

# POST-INITIALIZATION/FIXES
## Terminal
### General
export EDITOR='vim'
export VISUAL=$EDITOR
# export TERMINAL='gnome-terminal' # Use Gnome terminal as the default terminal
# export BROWSER='google-chrome-stable' # Browser

### Arch Linux
# alias pacmanSyua='sudo pacman -Syu --noconfirm' # Update all packages except for AUR packages.
# alias yaourtSyua='yaourt -Syua --noconfirm' # Update all packages, including AUR packages.

### SSH / Load ssh-agent and identities
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add

### Pipe Highlighting (requires 'highlight' be installed)
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"
export LESS=" -R"
alias less='less -m -N -g -i -J --line-numbers --underline-special'
alias more='less'
alias cath="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"
alias c="clear"

### JS/Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Python
# source $HOME/dev/venvs/dev-python2/bin/activate
source $HOME/dev/venvs/dev-python3/bin/activate

# SYSTEM ADMINISTRATION
## Arch Linux
## Ubuntu Linux
# alias aptMe='sudo apt update && sudo apt dist-upgrade -y'
## Arch Linux
# pacmanMe='sudo pacman -Syu --noconfirm'
# yaourtMe='yaourt -Syua --noconfirm'
# ArchNeedReboot() {
#   [[ $(pacman -Q linux | cut -d " " -f 2) > $(uname -r) ]] && echo reboot
# }
### Mac OS X
alias brewme='brew update && brew upgrade && brew cleanup'

# Useful key bindings and fuzzy completion:
# MISC CUSTOM FUNCTIONS
## calc(): A command line calculator using bc
calc() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# ADDED BY OTHER PROGRAMS
## tabtab source for serverless package
## uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/rick/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/rick/node_modules/tabtab/.completions/serverless.zsh
## tabtab source for sls package
## uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/rick/node_modules/tabtab/.completions/sls.zsh ]] && . /home/rick/node_modules/tabtab/.completions/sls.zsh

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
XZ_OPT=-t4

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/rick/.nvm/versions/node/v8.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/rick/.nvm/versions/node/v8.15.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
