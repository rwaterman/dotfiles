# Global Copilot Instructions

Project-level `.github/copilot-instructions.md` files override these.

## Context

Lead Cloud Architect. AWS serverless, platform engineering, data systems. 10+ years backend.

## Environment

macOS Tahoe. Shell: zsh (Oh-My-Zsh). Do not assume GNU coreutils — use BSD-compatible or POSIX flags. Bash scripts are fine; inline commands must be zsh-safe.

## Stack preferences

- TypeScript (Node.js 24+) for backend services and Lambda handlers.
- Python 3.12+ for scripts, data processing, and Lambda.
- Use current project patterns and frameworks. Terraform or AWS CDK (TypeScript) for IaC. Terraform when a package already uses it.
- Prefer ESM imports over CommonJS. Prefer `async/await` over raw Promises.

## Code style

- Explicit types over inference in function signatures. Infer locals.
- Early returns over deep nesting.
- Error handling: fail loudly with context. No bare `catch {}`.
- Name things precisely. Avoid abbreviations except well-known ones (e.g., `id`, `ctx`, `req`, `res`).
- Keep functions short and single-purpose.

## AWS conventions

- Infer region and account from caller environment. Don't hardcode or prompt.
- Lambda: single-purpose handlers, structured logging, middy middleware where appropriate.
- Prefer managed services (SQS, EventBridge, Step Functions) over custom orchestration.
- DynamoDB: single-table design when access patterns are known. Document key schema in comments.

## When generating code

- Include error handling from the start, not as an afterthought.
- Add concise inline comments for non-obvious logic only. Don't narrate the obvious.
- Tests: colocate with source. Prefer integration tests for Lambda, unit tests for pure logic.
- Never generate placeholder/TODO implementations without flagging them clearly.

## Formatting

- Prose by default in chat responses. Bullets only when list-shaped.
- No decorative emoji. Fenced code blocks with language hints.
- Commit messages and PR titles: match the project's existing convention.
