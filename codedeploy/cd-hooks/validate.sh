#!/usr/bin/env bash
set -euo pipefail

HEALTH_URL="http://localhost:8000/ai/api/health"
MAX_WAIT=60
SLEEP=2

for ((t=0; t<MAX_WAIT; t+=SLEEP)); do
  if curl -sf "$HEALTH_URL" >/dev/null; then
    echo "Validate OK: $HEALTH_URL"
    exit 0
  fi
  echo "Waiting health... (${t}s)"
  sleep "$SLEEP"
done

echo "Validate FAILED: $HEALTH_URL"
exit 1
