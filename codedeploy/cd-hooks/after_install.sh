#!/usr/bin/env bash
set -euo pipefail

BASE="/home/ubuntu/opt/ai-prod"
TAR="$BASE/incoming/ai-app.tar.gz"
DEPLOY="$BASE/scripts/deploy_bigbang.sh"

chmod +x "$DEPLOY"
"$DEPLOY" "$TAR"