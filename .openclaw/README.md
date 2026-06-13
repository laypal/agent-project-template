# .openclaw Directory

Agent-specific configuration and task specs for OpenClaw pipeline.

## Structure
```
.openclaw/
├── README.md           # This file
├── scripts/            # Tool-result-hygiene contract (compact results for the pipeline)
│   ├── test-summary.sh   # → {"tests_passed":N,"tests_failed":N,"type_errors":N}
│   └── report-digest.sh  # → commit + git diff --stat + test JSON (no full patch)
└── tasks/              # Feature spec files
    └── <feature>.md    # Spec for each feature
```

## Scripts — Tool-Result Hygiene

The pipeline's `test` and `report` steps call `.openclaw/scripts/` so agents receive a compact digest, not a 100k+ char tool dump (the single biggest token sink found in the production audit). Customise `test-summary.sh` for your stack (default: vitest + tsc). See AGENTS.md → "Tool-Result Hygiene".

## Task Spec Convention

Feature specs MUST be created at `.openclaw/tasks/<feature-name>.md` BEFORE running the pipeline.

The pipeline's `implement` step instructs Coder to:
1. Read the spec file first
2. Extract requirements verbatim (no paraphrasing)
3. Create ALL files listed in Target Files
4. Respect Non-Goals (do NOT implement anything listed there)
5. Verify each requirement word-for-word before committing
