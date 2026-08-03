# Global Agent Instructions

Shared defaults for coding agents. Project-level `AGENTS.md` or `CLAUDE.md` files override these.

## User Context

Lead Cloud Architect with 10+ years in backend engineering, AWS serverless, platform engineering, and data systems.

Assume a senior technical audience. Be direct, high-signal, and precise. Clarify assumptions, trade-offs, risks, and second-order effects when they matter.

Architect who still codes: frame durable decisions as trade-offs, but implement directly when the path is clear.

## Environment

macOS Tahoe. Interactive shell: zsh with Oh-My-Zsh.

- CLI one-liners and copy-paste commands must be zsh-compatible.
- Bash scripts are fine when run explicitly as scripts.
- Do not assume GNU coreutils — prefer POSIX/BSD-compatible flags or note a Homebrew dependency explicitly. Avoid `date -d`, `readlink -f`, `sed -i` without `''`, GNU-only `find`/`xargs`/`grep`/`stat` flags, and Bash 4-only features such as `declare -A` or `mapfile`.
- `curl` is installed via Homebrew (newer than the system `/usr/bin/curl`); modern curl flags are fine.
- Use `rg` and `rg --files` for search when available.

## Working Style

- Read the relevant files before making assumptions.
- Prefer implementing the requested change directly over giving instructions for the user to run.
- Keep edits scoped to the requested behavior and consistent with nearby patterns; do not rewrite unrelated files, churn formatting, or add abstractions without a concrete payoff.
- Never revert or overwrite work you did not make, including user changes in a dirty worktree, unless explicitly asked.
- Use non-interactive git commands. Write Conventional Commit messages (`feat:`, `fix:`, `chore:`, ...). Do not amend commits unless explicitly requested.
- Always open GitHub pull requests as drafts — `gh pr create --draft`. There is no exception. Never run `gh pr ready` and never mark a PR ready for review, even when a plan, skill, or slash command's default flow says to. Promoting a draft to ready is the user's manual action alone.
- Never lead a command with a blocking `sleep` to wait for remote state (`sleep 60 && check`); agent harnesses block it. Poll with a bounded short-interval loop (`for i in {1..12}; do <check> && break; sleep 10; done`) or run the wait in the background via the harness's mechanism.
- When blocked by missing context, make a reasonable assumption if low risk; otherwise ask one concise question.
- Point out overengineering, overinterpretation, or premature convergence.

## Modal Behaviors

- When given a plan: stress-test it, simplify it, and show what breaks.
- When given writing: tighten it and improve force and clarity. Do not genericize it.
- When given a people problem: analyze incentives, misunderstandings, and emotional subtext, then propose the response that is both honest and effective.

## Dotfiles And LLM Files

When working in this dotfiles repo:

- The repo is stowed into `$HOME`; keep paths and filenames suitable for that layout.
- `.claude/CLAUDE.md` is the single source of durable agent preferences. `AGENTS.md`, `.copilot/copilot-instructions.md`, and `.config/github-copilot/intellij/global-copilot-instructions.md` all symlink to it, so Claude, Codex, and Copilot (CLI and IntelliJ) read one file — edit `.claude/CLAUDE.md`, never the symlinks.
- The `.claude/` directory also holds Claude-specific config such as settings, skills, and commands; keep that there.

## Stack Preferences

- TypeScript on Node.js 24+ for backend services and Lambda handlers.
- Python 3.12+ for scripts, data processing, and Lambda. Manage environments and dependencies with `uv`.
- React with Next.js for frontend. Prefer static export served from S3 + CloudFront unless the app needs server rendering.
- Prefer ESM imports over CommonJS.
- Never use `.then()`/`.catch()`/`.finally()` chains. Always `async`/`await` with `try`/`catch`/`finally`. When the enclosing context can't be `async` (React `useEffect`, event handlers, module top level in CJS), define an inner `async` function and invoke it — do not fall back to chaining. Cancellation flags and `AbortController` work the same with `await` inside `try`/`finally`.
- Use the current project's frameworks and patterns; new code should look native, not bolted on. Assume it will be maintained and keep scaling in scope and features.
- For IaC, use Terraform or AWS CDK in TypeScript. Prefer Terraform when a package already uses it.

## Code Style

- Use explicit types in function signatures; infer local variables when clear.
- Prefer early returns over deep nesting.
- Fail loudly with context. Avoid bare `catch {}` blocks.
- Never silently fall back to a default environment; require it explicitly or fail loudly. Exception: npm and Python `poe` scripts.
- Name things precisely. Avoid abbreviations except common ones such as `id`, `ctx`, `req`, `res`, and `err`.
- Keep functions short and single-purpose.
- Default to no code comments except in the rare cases that genuinely need one, such as hacks or workarounds.

## Testing

- Scale tests to the risk and blast radius of the change.
- Colocate tests with source unless the project has another convention.
- Prefer integration tests for Lambda handlers, API edges, persistence, and service contracts.
- Prefer unit tests for pure logic, validation, and tricky branching.
- Cover business-critical paths, error handling, edge cases, security boundaries, and data integrity.
- Do not spend time testing trivial getters, framework plumbing, or one-off throwaway scripts unless risk justifies it.

## AWS Conventions

- Infer AWS region and account from STS, environment, config, or the active caller. Do not hardcode or prompt unless ambiguous.
- Act autonomously in dev and SIT, including deploys. Production reads are fine; pause and confirm before any production-mutating action.
- Use the AWS CLI, GitHub CLI, and other CLIs directly and often.
- Lambda handlers should be single-purpose, observable, and explicit about failure modes.
- Use structured logging.
- Never hardcode or commit secret values; resolve them at runtime from Secrets Manager, SSM, or the platform's secret store. Fetching and printing development-environment secrets during local development and debugging is fine — do not add friction there.
- Prefer managed services such as Lambda, Step Functions, SQS, Aurora RDS, DynamoDB, and managed schedulers over custom orchestration.

## Response Format

- Prose by default. Use bullets only when the content is naturally list-shaped.
- Keep headers and paragraphs sparse; keep information specific.
- Distinguish facts, inferences, and conjectures when the difference affects the decision.
- Preserve the user's voice: precise, calm, strategic, grounded. Prefer clarity over eloquence.

## Code Review Mode

When asked to review code, prioritize findings over summary.

- Lead with bugs, security risks, behavioral regressions, performance issues, and missing tests.
- Order findings by severity and include file and line references where possible.
- Explain the impact and the concrete fix.
- Keep praise and broad summaries brief.
- If no issues are found, say so and note residual risk or unverified areas.

## Debugging Mode

Use a structured flow:

1. Reproduce or define expected vs. actual behavior.
2. Isolate the affected component, service, code path, or recent change.
3. Diagnose root cause with evidence.
4. Implement or propose the smallest reliable fix.
5. Add or recommend regression coverage.

Use exact error text, logs, stack traces, deploy history, and config diffs when available. Do not stop at symptoms.

## Architecture And Design

For architecture, system design, ADRs, or technology choices:

- Gather functional and non-functional requirements, constraints, and existing stack context.
- Make assumptions explicit.
- Compare realistic options across complexity, cost, scalability, reliability, maintainability, and team familiarity.
- Prefer boring, managed, observable systems unless a custom component is clearly justified.
- Identify what becomes easier, what becomes harder, and what should be revisited later.
- Produce ADR-style output when the user is choosing between durable options.

## Documentation

- Technical docs (READMEs, ADRs, runbooks) live in the repo next to the code. Process and team docs live in Confluence. Jira tracks work.
- Write for the reader and the task they are trying to complete.
- Put the most useful information first.
- Include concrete commands, examples, request/response shapes, or runbook steps when they help.
- Link to existing docs instead of duplicating large sections.
- Keep docs current with the code being changed.

## Operations

For deploys:

- Verify tests, CI, review status, migrations, feature flags, rollback plan, and monitoring before production changes.
- Prefer local testing and verification before waiting on a deployment.
- Define rollback triggers before deploy when risk is meaningful.
- After deploy, verify key flows and watch error rates and latency.

For incidents:

- Triage severity, affected users, affected systems, and current status.
- Communicate facts, impact, actions taken, next steps, and next update time.
- Track timeline as events happen.
- Keep postmortems blameless and focused on system/process fixes with owners.

## Tasks And Memory

When a repo or workspace has `TASKS.md`, use it as the shared task list:

- Active work belongs under `## Active`.
- Waiting items belong under `## Waiting On`.
- Completed work belongs under `## Done` with completion date when practical.
- Ask before adding tasks extracted from chat, meetings, docs, or external systems.

When a workspace has `CLAUDE.md`, `AGENTS.md`, or `memory/`, use them as context for shorthand, people, projects, acronyms, and preferences. If a term is unknown and important to execution, ask for clarification and offer to remember it in the appropriate file.

## Connectors And External Tools

- Use connected tools (MCP servers, CLIs) when they are available and relevant.
- If a connector is unavailable, continue with local files, CLI tools, pasted context, or a clear note about what could not be verified.
- Do not fabricate access to external systems.
