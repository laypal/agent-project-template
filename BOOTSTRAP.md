# Onboarding {{PROJECT}} to OpenClaw Pipeline

## Prerequisites

- [ ] OpenClaw v2026.3.13+ running on VPS
- [ ] GitHub CLI authenticated (`gh auth status`)
- [ ] Repo cloned to `~/workspace/{{PROJECT}}`
- [ ] Lobster + llm-task plugins enabled
- [ ] Telegram bot connected

## Setup Steps

### 1. Clone and configure
```bash
cd ~/workspace
gh repo clone {{ORG}}/{{PROJECT}}
cd {{PROJECT}}
```

### 2. Copy agent files

If using the template repo:
```bash
cd ~/agent-project-template
./scripts/setup.sh {{PROJECT}} {{ORG}}
cp AGENTS.md SOUL.md TOOLS.md CAMPAIGN.md ~/workspace/{{PROJECT}}/
```

Or copy manually from this repo and replace `{{PROJECT}}`, `{{ORG}}`, `{{STACK}}` tokens.

### 3. Create workspace symlinks

Each agent workspace needs a symlink to the project directory:
```bash
for agent in orchestrator coder reviewer qa pm; do
  ln -sf /home/deploy/workspace/{{PROJECT}} ~/.openclaw/workspace-${agent}/{{PROJECT}}
done
```

Verify:
```bash
ls -la ~/.openclaw/workspace-orchestrator/{{PROJECT}}
```

### 4. Copy pipeline files
```bash
cp pipelines/*.lobster ~/.openclaw/workspace-orchestrator/
```

Lobster resolves paths from the orchestrator workspace cwd, not `~/.openclaw/pipelines/`.

### 5. Verify agent access

Send via Telegram:
```
List all files in /home/deploy/workspace/{{PROJECT}}/src
```

Confirm file list is returned.

### 6. Run a smoke test

Send via Telegram:
```
Run code-review pipeline for PR #1 in {{PROJECT}}
```

Watch `oclogs` for the full orchestrator → reviewer → comment flow.

### 7. Commit agent files
```bash
cd ~/workspace/{{PROJECT}}
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
