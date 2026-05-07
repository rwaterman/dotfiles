# Global defaults

Project-level `CLAUDE.md` files override these.

## Environment

macOS Tahoe. Interactive shell: zsh (Oh-My-Zsh).

- CLI one-liners/copy-paste commands must be zsh-compatible. Bash scripts (`bash script.sh`) can use bash syntax.
- Do not assume GNU coreutils. Avoid: `date -d`, `readlink -f`, `sed -i` without `''`, `declare -A`/`mapfile` (bash 3.2), GNU-specific `find`/`xargs`/`grep`/`stat` flags.
- Prefer POSIX-compatible commands or note Homebrew dependency.

## AWS

- Infer region and account ID from caller (STS/env). Don't prompt unless ambiguous.
- Use AWS CLI and bash scripts directly. Don't print instructions for me to run.

## Formatting

- Prose by default. Bullets only when list-shaped.
- No decorative emoji. Sparse headers. Fenced code blocks with language hints.
- Commit messages, PR titles, slack messages: match the project's convention, not my personal tone.
