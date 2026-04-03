# Onboarding KPI-Canvas to OpenClaw Pipeline

## Prerequisites

- [ ] OpenClaw v2026.3.13+ running on VPS
- [ ] GitHub CLI authenticated (`gh auth status`)
- [ ] Repo cloned to `~/workspace/KPI-Canvas`
- [ ] Lobster + llm-task plugins enabled
- [ ] Telegram bot connected

## Setup Steps

### 1. Clone and configure
```bash
cd ~/workspace
gh repo clone laypal/KPI-Canvas
cd KPI-Canvas
```

### 2. Copy agent files

If using the template repo:
```bash
cd ~/agent-project-template
./scripts/setup.sh KPI-Canvas laypal
cp AGENTS.md SOUL.md TOOLS.md CAMPAIGN.md ~/workspace/KPI-Canvas/
```

Or copy manually from this repo and replace `KPI-Canvas`, `laypal`, `TypeScript, Next.js, Supabase, Tailwind CSS` tokens.

### 3. Create workspace symlinks

Each agent workspace needs a symlink to the project directory:
```bash
for agent in orchestrator coder reviewer qa pm; do
  ln -sf /home/deploy/workspace/KPI-Canvas ~/.openclaw/workspace-${agent}/KPI-Canvas
done
```

Verify:
```bash
ls -la ~/.openclaw/workspace-orchestrator/KPI-Canvas
```

### 4. Copy pipeline files
```bash
cp pipelines/*.lobster ~/.openclaw/workspace-orchestrator/
```

Lobster resolves paths from the orchestrator workspace cwd, not `~/.openclaw/pipelines/`.

### 5. Verify agent access

Send via Telegram:
```
List all files in /home/deploy/workspace/KPI-Canvas/src
```

Confirm file list is returned.

### 6. Run a smoke test

Send via Telegram:
```
Run code-review pipeline for PR #1 in KPI-Canvas
```

Watch `oclogs` for the full orchestrator → reviewer → comment flow.

### 7. Commit agent files
```bash
cd ~/workspace/KPI-Canvas
git add AGENTS.md SOUL.md TOOLS.md CAMPAIGN.md
git commit -m "docs: add agent pipeline configuration files"
git push
```

## Post-Setup Checklist

- [ ] `oclogs` shows no errors during smoke test
- [ ] Reviewer can read the codebase
- [ ] QA can run `npm test` or equivalent
- [ ] PM can send Telegram summaries
- [ ] No secrets in git history (`git log --all --oneline -- '.env' 'openclaw.json'`)
- [ ] CAMPAIGN.md initialised with project metadata
