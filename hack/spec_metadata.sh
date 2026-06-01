#!/usr/bin/env bash
# Outputs document frontmatter metadata to stdout.
set -e

DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
RESEARCHER=$(git config user.name 2>/dev/null || echo "unknown")
GIT_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "unknown")
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
REPO=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" || echo "unknown")

cat <<EOF
date: $DATE
researcher: $RESEARCHER
git_commit: $GIT_COMMIT
branch: $BRANCH
repository: $REPO
EOF
