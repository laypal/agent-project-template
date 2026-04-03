# Agent Instructions — {{PROJECT_NAME}}

**Organisation:** {{ORG}}  **Stack:** TypeScript, Next.js, Supabase, Tailwind CSS  **Workspace:** `~/workspace/{{PROJECT_NAME}}`

---

## Agent Roster

| Agent | Role | Model | Max Output |
|---|---|---|---|
| Orchestrator | Pipeline coordination, task delegation | Gemini 2.5 Flash | 4096 |
| Coder | Implementation, feature development | MiniMax M2.7 | 8192 |
| Reviewer | Code review, security checks, quality gates | GPT-5.4 | 4096 |
| QA | Test execution, coverage reporting | Claude Haiku 4.5 | 4096 |
| PM | Task breakdown, prioritisation, summaries | Claude Haiku 4.5 | 2048 |

---

## Git Workflow

1. All work happens on feature branches: `feat/<feature-name>`
2. Never commit directly to `main`
3. Create PR via `gh pr create` after implementation
4. Reviewer checks PR before merge
5. QA runs tests on the feature branch

### Branch naming
- Features: `feat/<name>`
- Fixes: `fix/<name>`
- Tests: `test/<name>`

### Commit messages
Use conventional commits: `feat:`, `fix:`, `test:`, `docs:`, `chore:`

---

## Task Spec Files

Feature specs live in `.openclaw/tasks/<feature-name>.md`. When implementing a feature, Coder MUST:

1. **Read the spec file first** using `cat .openclaw/tasks/<feature>.md`
2. **Extract requirements verbatim** — do not paraphrase
3. **Create ALL files** listed in "Target Files" section
4. **Respect Non-Goals** — do NOT implement anything listed there
5. **Verify before commit** — check each requirement word-for-word

---

## Testing Conventions

**Every new component or feature MUST include tests.**

| File Type | Test Location |
|-----------|---------------|
| `src/features/X/components/foo.tsx` | `src/features/X/components/__tests__/foo.test.tsx` |
| `src/features/X/lib/bar.ts` | `src/features/X/lib/__tests__/bar.test.ts` |

### Testing Quality Checklist

1. Use `userEvent` not `element.click()` - Avoids React act warnings
2. Assert behavior, not just presence - Prove functionality works
3. Assert disabled states for pagination/interactive elements
4. Test negative cases - Verify things that should NOT happen

### UI Component Conventions

- Use shadcn components not raw HTML
- Use Tailwind classes not inline styles
- Follow existing component patterns

---

## Agent-Specific Instructions

### Coder
- Read spec file first, extract requirements verbatim
- Create ALL files listed in Target Files
- Respect Non-Goals
- Verify each requirement before committing

### Reviewer
- FIRST: Verify implementation matches spec word-for-word
- If spec requirement missing -> blocking issue
- SECOND: Check security, types, tests

### PM
- Summarise with: commit hash, files changed, requirements status, test results
- Send detailed summary to Telegram

---

## Security Rules

- NEVER hard-code secrets or tokens
- NEVER commit .env files
- All file operations restricted to workspace
