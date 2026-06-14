#### Listing (eza) ############################################################

alias ls='eza --icons --git'
alias l='eza -lh --icons --git' # Detailed listing
alias la='eza -lah --icons --git' # Detailed listing including hidden files
alias t='eza --tree --icons' # Tree view

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

#### Core utilities ###########################################################
# Better cat
alias cat='bat'
alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'

# Safe mkdir default: create parents automatically.
# `command` ensures the real binary is called, not this alias (prevents recursion).
alias mkdir='command mkdir -p'

#### Editors ##################################################################
alias vim='nvim'
alias nv='nvim'

#### Git ######################################################################
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gca='git commit --verbose --all'
alias gcam='git commit --all --message'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gl='git pull'
alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'
alias gm='git merge'
alias gma='git merge --abort'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grh='git reset'
alias grhh='git reset --hard'
alias grs='git restore'
alias grss='git restore --staged'
alias gst='git status'
alias gsta='git stash push'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsw='git switch'
alias gswc='git switch --create'
alias git_branch_cleanup="git branch --no-color | fzf -m | xargs -I {} git branch -D '{}'"
alias gh_run_watch='gh run watch --compact && ntfy pub $NTFY_TOPIC "Success" || ntfy pub $NTFY_TOPIC "Failed"'

#### Terraform ################################################################
alias tffv="terraform fmt && terraform validate"
alias tfplan='terraform plan -out="tfplan"'
alias tfapply='terraform apply "tfplan"'
alias tfdeploy='tffv && tfplan && tfapply'
alias tfdestroy='tffv && terraform plan -destroy -out="tfplan" && tfapply'

#### NPM / Node ###############################################################
alias nuke_d_ts_files="find . -name '*.d.ts' -not -path './node_modules/*' -delete"
alias nuke_node_modules_dirs="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias nuke_idea_dirs='find . -name ".idea" -type d -prune -print -exec rm -rfv "{}" +'

#### Docker ###################################################################
alias nuke_docker='
  docker ps -a -q | xargs -r docker rm -f &&
  docker volume ls -q | xargs -r docker volume rm &&
  docker network ls --format "{{.Name}}" | command grep -vE "^(bridge|host|none)$" | xargs -r docker network rm &&
  docker images -q | xargs -r docker rmi -f
'

#### Internet #################################################################
alias whatismyip='curl ifconfig.me'
alias check_ping="ping google.com -c 10"

#### Pager (requires 'highlight') #############################################
if have highlight; then
  alias less='less -m -N -g -i -J --line-numbers --underline-special'
  alias more='less'
  alias cath="highlight \$1 --out-format xterm256 --line-numbers --quiet --force --style zenburn"
fi

#### System Admin (OS-aware) ##################################################
# Homebrew (macOS or Linuxbrew)
if have brew; then
  alias brewme='brew update && brew upgrade && brew cleanup'
fi
# Arch
if is_linux && have pacman; then
  alias pacme='sudo pacman -Syu --noconfirm'
fi
# Debian/Ubuntu
if is_linux && have apt; then
  alias aptme='sudo apt update && sudo apt upgrade -y'
fi
