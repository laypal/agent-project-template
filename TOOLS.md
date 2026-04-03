# Approved Tools — KPI-Canvas

## Exec Allowlist (all agents)

These commands are pre-approved for all agents without human confirmation:

git, gh, npm, npx, node, ls, cat, mkdir, cp, mv, rm, find, grep, sed, awk, curl, jq, tsc, vitest, playwright, next

Any command not on this list triggers a human approval prompt.

## Per-Agent Tool Access

### Orchestrator

- **Exec:** Full allowlist
- **Agent-to-agent:** Can delegate to all agents
- **Telegram:** Send/receive messages
- **GitHub:** Full access (PR creation, comments, merges)

### Coder

- **Exec:** Allowlist only (no `rm -rf`, no `sudo`)
- **File system:** Workspace only (`~/workspace/KPI-Canvas`)
- **GitHub:** Read + push to feature branches only
- **Agent-to-agent:** Cannot delegate (receives tasks only)

### Reviewer

- **Exec:** Read-only commands (`cat`, `grep`, `find`, `git diff`, `git log`)
- **File system:** Read-only workspace access
- **GitHub:** Post PR comments, request changes
- **Agent-to-agent:** Can send feedback to Coder (via Orchestrator)

### QA

- **Exec:** Test runners only (`vitest`, `playwright`, `npm test`, `tsc --noEmit`)
- **File system:** Read-only workspace access
- **GitHub:** Post test results as PR comments
- **Agent-to-agent:** Cannot delegate

### PM

- **Exec:** None (no shell access)
- **File system:** Read-only workspace access
- **Telegram:** Send summaries and status updates
- **Agent-to-agent:** Can request task breakdown from Orchestrator

## Elevated Commands

Commands requiring WebUI approval (cannot be approved via Telegram):

- `docker` anything
- `systemctl` anything
- `apt` / `apt-get`
- File operations outside workspace
- Network configuration changes

## Web Search

- Brave Search is enabled for all agents
- Use for: library documentation, error messages, API references
- Do not use for: generating code from search results, copying Stack Overflow answers verbatim
