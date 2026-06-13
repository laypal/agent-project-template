name: dev-pipeline
description: Code → review → test for a feature branch
args:
  feature:
    required: true
  project:
    default: "KPI-Canvas"
steps:
  - id: checkout
    command: "cd /home/deploy/workspace/${project} && git checkout -b feat/${feature}"
  - id: implement
    command: "openclaw agent --to agent:coder:main --message 'Implement feature: ${feature} in /home/deploy/workspace/${project}'"
  - id: review
    command: "openclaw agent --to agent:reviewer:main --message 'Review the latest changes in /home/deploy/workspace/${project} against main'"
  - id: test
    command: "if [ -x /home/deploy/workspace/${project}/.openclaw/scripts/test-summary.sh ]; then /home/deploy/workspace/${project}/.openclaw/scripts/test-summary.sh | tee /tmp/test-${feature}.json; else openclaw agent --to agent:qa:main --message 'Run the full test suite in /home/deploy/workspace/${project} and report results as JSON {tests_passed,tests_failed,type_errors}'; fi"
  - id: report
    command: "/home/deploy/workspace/${project}/.openclaw/scripts/report-digest.sh '${feature}' > /tmp/report-digest-${feature}.md 2>/dev/null || true; openclaw agent --to agent:pm:main --message 'Read /tmp/report-digest-${feature}.md (commit, files changed, test results) and summarise the pipeline result; send a Telegram summary. Do NOT run git diff — the digest already has the file list and test results.'"
