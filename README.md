# agent-project-template

Reusable template for onboarding projects to an OpenClaw multi-agent coding pipeline.

## Quick Start
```bash
git clone https://github.com/laypal/agent-project-template.git
cd agent-project-template
./scripts/setup.sh <PROJECT_NAME> <ORG_NAME> [STACK]
```

Default stack: `TypeScript, Next.js, Supabase, Tailwind CSS`

## What's included

| File | Purpose |
|---|---|
| `AGENTS.md` | Per-agent instructions, roster, git workflow, security rules |
| `SOUL.md` | Agent identity, tone, pipeline vs interactive mode behaviour |
| `TOOLS.md` | Exec allowlist, per-agent tool access, elevated commands |
| `BOOTSTRAP.md` | Step-by-step project onboarding checklist |
| `CAMPAIGN.md` | Persistent session log — what was built, decisions, blockers |
| `pipelines/dev-pipeline.lobster` | Full dev pipeline: checkout → code → review → test → report |
| `pipelines/code-review.lobster` | Standalone PR review pipeline |
| `pipelines/quality-gate.lobster` | Binary quality checks (tsc, lint, test) before PR creation |
| `scripts/setup.sh` | Token replacement script |
| `.cursor/rules/` | Cursor IDE rules for agent-managed projects |

## Template tokens

All files use these placeholders, replaced by `setup.sh`:

- `{{PROJECT}}` — project name (e.g., `KPI-Canvas`)
- `{{ORG}}` — GitHub organisation (e.g., `laypal`)
- `{{STACK}}` — tech stack description

## Prerequisites

- OpenClaw v2026.3.13+
- GitHub CLI (`gh`) authenticated
- Lobster + llm-task plugins enabled
- Telegram bot connected

## Pipeline architecture
```
User (Telegram) → Orchestrator → Coder → Reviewer → QA → PM → User (Telegram)
                                    ↑         |
                                    └─────────┘
                                   (max 3 iterations)
```

Lobster handles sequencing and retry logic. LLMs handle code generation and review. No LLM-driven routing.

## After setup

See `BOOTSTRAP.md` for the full onboarding checklist.
