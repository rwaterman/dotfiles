# @author Rick Waterman
# @copyright MIT License
# .zshrc

# STARTUP INITIALIZATION
export LANG='en_US.UTF-8' # Set system language to US English with UTF-8 character encoding
export TERM='screen-256color' # Turn on 256 colors (as opposed to 16) in the terminal
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/$USER/bin"
setopt extended_glob # Enables extended globbing (expansion) features

## oh-my-zsh initialization

## oh-my-zsh plugins
plugins=(
  bundler
  docker
  git
  node
  npm
  nvm-zsh
  python
  ruby
  tmux
  wd
)

### oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="xiong-chiamiov-plus"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"

ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"
source $ZSH/oh-my-zsh.sh

# POST-INITIALIZATION/FIXES
## Terminal
### General
stty -ixon # Prevent terminal freezing
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
alias cat="highlight $1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"

### JS/Node
alias npmr='npm run'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Python
source $HOME/dev/venvs/dev-python2/bin/activate
# source $HOME/dev/venvs/dev-python3/bin/activate

## Ruby
eval "$(rbenv init -)"

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
alias brewme='brew update && brew upgrade && brew cleanup && brew prune'

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

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"