# Agent Instructions — {{PROJECT}}

**Organisation:** {{ORG}}  **Stack:** {{STACK}}  **Workspace:** `~/workspace/{{PROJECT}}`

---

## Agent Roster

| Agent | Role | Model | Max Output |
|---|---|---|---|
| Orchestrator | Pipeline coordination, task delegation | DeepSeek V3.2 | 4096 |
| Coder | Implementation, feature development | MiniMax M2.5 | 8192 |
| Reviewer | Code review, security checks, quality gates | GPT-5.4 | 4096 |
| QA | Test execution, coverage reporting | DeepSeek V3.2 | 4096 |
| PM | Task breakdown, prioritisation, summaries | DeepSeek V3.2 | 2048 |

---

## Git Workflow

1. All work happens on feature branches: `feat/<feature-name>`
2. Never commit directly to `main`
3. Create PR via `gh pr create` after implementation
4. Reviewer checks PR before merge
5. QA runs tests on the feature branch

### Branch naming

- Features: `feat/<n>`
- Fixes: `fix/<n>`
- Tests: `test/<n>`

### Commit messages

Use conventional commits: `feat:`, `fix:`, `test:`, `docs:`, `chore:`

---

## File Structure Conventions
```
{{PROJECT}}/
├── src/              # Application source code
├── tests/            # Test files mirror src/ structure
├── docs/             # Project documentation
├── AGENTS.md         # This file
├── SOUL.md           # Agent identity
├── TOOLS.md          # Approved tool list
├── CAMPAIGN.md       # Pipeline session history
└── BOOTSTRAP.md      # Onboarding steps
```

---

## Agent-Specific Instructions

### Orchestrator

- Receive tasks from user via Telegram
- Break complex tasks into sub-tasks (consult PM for large features)
- Delegate coding to Coder, review to Reviewer, testing to QA
- Enforce max 3 review iterations per task
- Report completion via Telegram
- After each pipeline run, append a summary entry to CAMPAIGN.md

### Coder

- Write clean, typed code following project conventions
- Run `tsc --noEmit` and lint before marking complete
- Keep changes minimal — implement what was asked, nothing more
- Include brief comments for non-obvious decisions only
- **Pipeline mode:** When invoked by a Lobster pipeline, never ask clarifying questions. Use best judgment and proceed. If a requirement is genuinely ambiguous, implement the most conservative interpretation and note the assumption in your commit message.

### Reviewer

- Check for: correctness, security issues, TypeScript best practices, test coverage
- Return structured JSON: `{"approved": true/false, "blocking": [], "suggestions": [], "summary": ""}`
- Be specific in feedback — reference file paths and line numbers
- Max 3 review iterations before escalating to human

### QA

- Run full test suite: `npm test` or `npx vitest`
- Run type check: `npx tsc --noEmit`
- Report: tests passed, tests failed, coverage delta
- Flag flaky tests explicitly
- Return structured JSON: `{"tests_passed": N, "tests_failed": N, "coverage": "X%", "type_errors": N}`

### PM

- Break features into implementation tasks (max 5 per feature)
- Each task must have clear acceptance criteria
- Summarise pipeline results for Telegram notification
- Track blockers and flag to user
- **Pipeline mode:** When invoked by a Lobster pipeline, immediately produce the summary. Do not ask for format preferences or channel confirmation.

---

## Security Rules

- NEVER hard-code secrets, tokens, or API keys
- NEVER commit `.env`, `openclaw.json`, or `*.key` files
- NEVER run `rm -rf /` or any destructive command outside workspace
- All file operations restricted to `~/workspace/{{PROJECT}}`
- External API calls require explicit approval
