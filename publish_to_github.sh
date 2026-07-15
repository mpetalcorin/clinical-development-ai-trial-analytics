#!/usr/bin/env bash
set -euo pipefail

OWNER="mpetalcorin"
REPO="clinical-development-ai-trial-analytics"
DESCRIPTION="End-to-end clinical trial simulation, SDTM/ADaM workflows, PK, safety, survival, biomarker analytics, and governed generative AI."

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI is required. Install it on macOS with: brew install gh" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  gh auth login
fi

if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/$OWNER/$REPO.git"
  git push -u origin main
else
  git remote remove origin >/dev/null 2>&1 || true
  gh repo create "$OWNER/$REPO" \
    --public \
    --description "$DESCRIPTION" \
    --source=. \
    --remote=origin \
    --push
fi

echo "Published: https://github.com/$OWNER/$REPO"
