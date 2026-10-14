# Helpers
is_macos() { [[ "$OSTYPE" == darwin* ]]; }
is_linux() { [[ "$OSTYPE" == linux* ]]; }
have() { command -v "$1" >/dev/null 2>&1; }
source_if_exists() { [ -f "$1" ] && source "$1"; }

calc() {
  local calc="${*//p/+}"
  calc="${calc//x/*}"
  bc -l <<<"scale=10;$calc"
}

# Fast-forward a repo's develop (or main) from origin without switching branches or touching uncommitted work
git_update_default_branch() {
  emulate -L zsh
  local repo="${1:-$PWD}"
  local default
  if git -C "$repo" show-ref --verify -q refs/remotes/origin/develop; then
    default=develop
  elif git -C "$repo" show-ref --verify -q refs/remotes/origin/main; then
    default=main
  else
    print -u2 "git_update_default_branch: no origin/develop or origin/main in $repo"
    return 1
  fi

  if [[ "$(git -C "$repo" symbolic-ref -q --short HEAD)" == "$default" ]]; then
    git -C "$repo" pull --ff-only origin "$default"
  else
    git -C "$repo" fetch origin "$default:$default"
  fi
}

# Update the default branch of every repo one level below a directory (default: $PWD).
# Linked worktrees share their main repo's branches, so only main repos are visited.
git_pull_all() {
  emulate -L zsh
  local root="${1:-$PWD}"
  [[ -d "$root" ]] || { print -u2 "git_pull_all: not a directory: $root"; return 1; }

  local -a failed
  local dir
  for dir in "$root"/*(N/); do
    [[ -d "$dir/.git" ]] || continue
    print -P "%F{cyan}==> ${dir:t}%f"
    git_update_default_branch "$dir" || failed+=("${dir:t}")
  done

  (( ${#failed} )) || return 0
  print -u2 -P "%F{red}Failed: ${(j:, :)failed}%f"
  return 1
}
