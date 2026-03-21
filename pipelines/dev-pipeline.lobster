name: dev-pipeline
description: Code → review → test for a feature branch
args:
  feature:
    required: true
  project:
    default: "{{PROJECT}}"
steps:
  - id: checkout
    command: "cd /home/deploy/workspace/${project} && git checkout -b feat/${feature}"
  - id: implement
    command: "openclaw agent --to agent:coder:main --message 'Implement feature: ${feature} in /home/deploy/workspace/${project}'"
  - id: review
    command: "openclaw agent --to agent:reviewer:main --message 'Review the latest changes in /home/deploy/workspace/${project} against main'"
  - id: test
    command: "openclaw agent --to agent:qa:main --message 'Run the full test suite in /home/deploy/workspace/${project} and report results'"
  - id: report
    command: "openclaw agent --to agent:pm:main --message 'Summarise pipeline result for feature ${feature} and send Telegram summary'"
