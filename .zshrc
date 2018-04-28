# @author Rick Waterman
# @copyright MIT License
# .zshrc

# ENVIRONMENT VARIABLES #
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/$USER/bin:/home/$USER/Android/Sdk/tools" # Create/Update File system PATH
export LANG='en_US.UTF-8' # Set system language to US English with UTF-8 character encoding

## Ensure Python2 is the default ##
export PYTHON='python2'
export python='/usr/bin/python2'

## Terminal ##
export TERMINAL='gnome-terminal' # Use Gnome terminal as the default terminal
export TERM='screen-256color' # Turn on 256 colors (as opposed to 16) in the terminal
export BROWSER='google-chrome-stable' # Browser

## Use Vim as the default text editor ##
export EDITOR='vim'
export VISUAL=$EDITOR

# ALIASES #
alias c='clear' # Clear the screen
## Arch Linux ##
alias pacmanSyua='sudo pacman -Syu --noconfirm' # Update all packages except for AUR packages.
alias yaourtSyua='yaourt -Syua --noconfirm' # Update all packages, including AUR packages.
alias reflectorUpdate='sudo systemctl start reflector'   # Reflector systemd service must be created for this to work first (see Reflector page on Arch Wiki)
## Vanilla Zsh Settings ##
setopt extended_glob # Enables extended globbing (expansion) features


# OH-MY-ZSH #
export ZSH=$HOME/.oh-my-zsh # oh-my-zsh configuration file
ZSH_THEME="agnoster" # oh-my-zsh theme
COMPLETION_WAITING_DOTS="true" # The waiting dots appear during tab completions
DISABLE_UNTRACKED_FILES_DIRTY="false"

## oh-my-zsh Plugins ##
plugins=(git tmux)

### Tmux Plugin Options ###
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"

## Load oh-my-zsh ##
source $ZSH/oh-my-zsh.sh # Required for Oh My Zsh

# HACKS AND FIXES
stty -ixon # Unbinds C-s so the terminal doesn't freeze up. This is so I can use the same keymapping to save a file when inside Vim


# CUSTOM FUNCTIONS

# calc(): A command line calculator using bc
calc() {
  calc="${@//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}


# Arch Linux Specific Functions
ArchNeedReboot() {
  [[ $(pacman -Q linux | cut -d " " -f 2) > $(uname -r) ]] && echo reboot
}


# Ubuntu Linux Specific Functions
aptUpdateUpgrade() {
  sudo apt update && sudo apt dist-upgrade -y
}

export ANDROID_HOME=/home/rick/Android/Sdk
export PATH=$PATH:$ANDROID_HOME:/home/rick/Android/Sdk/tools
export PATH=$PATH:$ANDROID_HOME:/home/hari/Android/Sdk/platform-tools

###-tns-completion-start-###
if [ -f /home/rick/.tnsrc ]; then 
    source /home/rick/.tnsrc 
fi
###-tns-completion-end-###

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/rick/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/rick/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/rick/node_modules/tabtab/.completions/sls.zsh ]] && . /home/rick/node_modules/tabtab/.completions/sls.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
