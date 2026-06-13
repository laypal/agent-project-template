#!/usr/bin/env bash
# .openclaw/scripts/test-summary.sh — TEST-SUMMARY CONTRACT (tool-result hygiene).
# Print ONE line: {"tests_passed":N,"tests_failed":N,"type_errors":N}. No verbose logs.
# The pipeline `test` step calls this so agents receive a digest, not a 100k+ char test dump.
# >>> CUSTOMISE the commands below for your stack. Default = vitest + tsc (Next.js/TS). <<<
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 1            # repo root
vj="$(mktemp)"
npx vitest run --reporter=json --outputFile="$vj" >/dev/null 2>&1
passed=$(jq -r '.numPassedTests // 0' "$vj" 2>/dev/null || echo 0)
failed=$(jq -r '.numFailedTests // 0' "$vj" 2>/dev/null || echo 0)
rm -f "$vj"
type_errors=$(npm run --silent type-check 2>&1 | grep -cE 'error TS' || true)
printf '{"tests_passed":%s,"tests_failed":%s,"type_errors":%s}\n' "${passed:-0}" "${failed:-0}" "${type_errors:-0}"
