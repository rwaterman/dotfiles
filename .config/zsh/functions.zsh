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

# Fast-forward a repo's local develop, main or master (first found on origin) without switching branches or touching uncommitted work
git_pull_base_branch() {
  emulate -L zsh
  local repo="${1:-$PWD}"
  local heads
  heads=$(git -C "$repo" ls-remote --heads origin) || {
    print -u2 "git_pull_base_branch: cannot list branches on origin for $repo"
    return 1
  }
  local -a branches=(${${(f)heads}#*$'\t'refs/heads/})
  local base candidate
  for candidate in develop main master; do
    if (( ${branches[(Ie)$candidate]} )); then
      base=$candidate
      break
    fi
  done
  if [[ -z "$base" ]]; then
    print -u2 "git_pull_base_branch: origin has no develop, main or master branch for $repo"
    return 1
  fi

  if [[ "$(git -C "$repo" symbolic-ref -q --short HEAD)" == "$base" ]]; then
    git -C "$repo" fetch origin "$base" &&
      git -C "$repo" merge --ff-only --no-autostash --no-overwrite-ignore FETCH_HEAD
  else
    git -C "$repo" fetch origin "$base:$base"
  fi
}

# Pull the base branch of every repo one level below a directory (default: $PWD).
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
    git_pull_base_branch "$dir" || failed+=("${dir:t}")
  done

  (( ${#failed} )) || return 0
  print -u2 -P "%F{red}Failed: ${(j:, :)failed}%f"
  return 1
}
