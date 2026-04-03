# .openclaw Directory

Agent-specific configuration and task specs for OpenClaw pipeline.

## Structure
```
.openclaw/
├── README.md           # This file
└── tasks/              # Feature spec files
    └── <feature>.md    # Spec for each feature
```

## Task Spec Convention

Feature specs MUST be created at `.openclaw/tasks/<feature-name>.md` BEFORE running the pipeline.

The pipeline's `implement` step instructs Coder to:
1. Read the spec file first
2. Extract requirements verbatim (no paraphrasing)
3. Create ALL files listed in Target Files
4. Respect Non-Goals (do NOT implement anything listed there)
5. Verify each requirement word-for-word before committing
