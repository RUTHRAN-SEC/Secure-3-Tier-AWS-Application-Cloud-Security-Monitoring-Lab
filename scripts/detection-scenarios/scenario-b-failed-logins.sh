#!/usr/bin/env bash
# Scenario B — Excessive failed access attempts
# Simulates repeated failed SSH logins against your own lab EC2 instance
# to generate log entries for a brute-force-style detection.
#
# Run only against infrastructure you own. Replace HOST with your lab EC2 public IP/DNS.

set -euo pipefail

HOST="${1:?Usage: $0 <ec2-host>}"
ATTEMPTS=10

echo "[*] Simulating $ATTEMPTS failed SSH logins against $HOST"
for i in $(seq 1 "$ATTEMPTS"); do
  echo "  attempt $i"
  ssh -o BatchMode=yes -o ConnectTimeout=3 -o StrictHostKeyChecking=no \
    "definitely-not-a-real-user@$HOST" "true" 2>/dev/null || true
  sleep 1
done

echo "[*] Done. Check the EC2 instance's auth logs (or CloudWatch Logs if the agent is shipping them)"
echo "    for repeated 'Failed password' / 'Invalid user' entries from this source."
