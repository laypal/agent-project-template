# Agent Pipeline Rules

## Context

This project is managed by an OpenClaw multi-agent pipeline. When reviewing PRs created by agents, apply these rules.

## Review checklist

1. **Type safety** — no `any`, proper error handling, null checks
2. **Security** — no XSS, SQL injection, auth gaps, missing RLS policies
3. **Patterns** — follows existing codebase patterns, no inconsistencies
4. **Tests** — adequate coverage, edge cases, unhappy paths tested
5. **Performance** — no N+1 queries, unnecessary re-renders, missing memoisation
6. **Dependencies** — no unnecessary new packages, pinned versions

## Conventions

- Conventional commits: `feat:`, `fix:`, `test:`, `docs:`, `chore:`
- Feature branches: `feat/<n>`, fix branches: `fix/<n>`
- Never commit `.env`, `openclaw.json`, or secrets
- Keep changes minimal — one logical change per PR
