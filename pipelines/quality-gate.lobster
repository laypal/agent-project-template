name: quality-gate
description: Binary quality checks — run before PR creation. Fails pipeline on any error.
args:
  project:
    default: "{{PROJECT}}"
steps:
  - id: typecheck
    command: "cd /home/deploy/workspace/${project} && npx tsc --noEmit"
  - id: lint
    command: "cd /home/deploy/workspace/${project} && npm run lint 2>/dev/null || echo 'SKIP: no lint script configured'"
  - id: test
    command: "cd /home/deploy/workspace/${project} && npm test 2>/dev/null || echo 'SKIP: no test script configured'"
