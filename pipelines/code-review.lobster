name: code-review
description: Standalone PR review — replaces CodeRabbit
args:
  pr:
    required: true
  project:
    default: "KPI-Canvas"
steps:
  - id: fetch-pr
    command: "cd /home/deploy/workspace/${project} && gh pr checkout ${pr} --repo laypal/${project}"
  - id: review
    command: "openclaw agent --to agent:reviewer:main --message 'Review PR ${pr} in /home/deploy/workspace/${project}, check for bugs, security issues, and code style'"
  - id: comment
    command: "openclaw agent --to agent:reviewer:main --message 'Post review summary as GitHub PR comment on PR ${pr} in laypal/${project}'"
