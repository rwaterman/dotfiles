# Connectors

## How tool references work

Skill files use `~~category` as a placeholder for whatever tool is connected in that category. For example, `~~source control` might mean GitHub, GitLab, or any other VCS with an MCP server.

Skills are **tool-agnostic** — they describe workflows in terms of categories (source control, project tracker, chat, etc.) rather than specific products. Whichever MCP server is connected in a category satisfies that placeholder.

## Connectors referenced by installed skills

| Category | Placeholder | Typical servers | Other options |
|----------|-------------|-----------------|---------------|
| Chat | `~~chat` | Slack | Microsoft Teams, Discord |
| Email | `~~email` | Microsoft 365, Gmail | — |
| Calendar | `~~calendar` | Microsoft 365, Google Calendar | — |
| Source control | `~~source control` | GitHub | GitLab, Bitbucket |
| Project tracker | `~~project tracker` | Asana, Linear, Atlassian (Jira/Confluence), monday.com, ClickUp | Shortcut, Basecamp, Wrike |
| Knowledge base | `~~knowledge base` | Notion | Confluence, Guru, Coda |
| Monitoring | `~~monitoring` | Datadog | New Relic, Grafana, Splunk |
| Incident management | `~~incident management` | PagerDuty | Opsgenie, Incident.io, FireHydrant |
| CI/CD | `~~CI/CD` | — | CircleCI, GitHub Actions, Jenkins, BuildKite |
| Office suite | `~~office suite` | Microsoft 365 | — |
