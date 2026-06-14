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
