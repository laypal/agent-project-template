#!/usr/bin/env bash
# .openclaw/scripts/report-digest.sh <feature> — REPORT-DIGEST CONTRACT (tool-result hygiene).
# Emits a COMPACT markdown digest for the PM `report` step: commit + changed-file STAT
# (never the full patch) + the test JSON. Keeps PM's input small instead of a raw git diff.
set -uo pipefail
feature="${1:-unknown}"
cd "$(dirname "$0")/../.." || exit 1            # repo root
echo "## Pipeline digest: ${feature}"
echo
echo "### Commit"; git log -1 --format='%h %s' 2>/dev/null || echo "(none)"
echo
echo "### Files changed (vs main)"; git diff --stat main...HEAD 2>/dev/null | tail -40 || echo "(none)"
echo
echo "### Test results"
if [ -f "/tmp/test-${feature}.json" ]; then cat "/tmp/test-${feature}.json"; else echo "(test summary not found — test step writes it)"; fi
