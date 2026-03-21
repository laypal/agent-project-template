#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: ./scripts/setup.sh <PROJECT_NAME> <ORG_NAME> [STACK]"
  echo "  STACK defaults to 'TypeScript, Next.js, Supabase, Tailwind CSS'"
  exit 1
fi

PROJECT="$1"
ORG="$2"
STACK="${3:-TypeScript, Next.js, Supabase, Tailwind CSS}"

echo "Setting up agent template for: $PROJECT ($ORG)"
echo "Stack: $STACK"
echo ""

for file in AGENTS.md SOUL.md TOOLS.md BOOTSTRAP.md CAMPAIGN.md pipelines/*.lobster; do
  if [ -f "$file" ]; then
    sed -i "s/{{PROJECT}}/$PROJECT/g" "$file"
    sed -i "s/{{ORG}}/$ORG/g" "$file"
    sed -i "s/{{STACK}}/$STACK/g" "$file"
    echo "  ✓ $file"
  fi
done

echo ""
echo "Done. Review files before committing."
echo "Next: copy AGENTS.md, SOUL.md, TOOLS.md, CAMPAIGN.md to ~/workspace/$PROJECT/"
