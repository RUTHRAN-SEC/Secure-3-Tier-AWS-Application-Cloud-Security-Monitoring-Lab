#!/usr/bin/env bash
# Scenario C — Public database exposure check
# Checks whether the lab RDS instance is publicly accessible, and (with --fix)
# corrects it. Intended to demonstrate a before/after finding for the portfolio.

set -euo pipefail

DB_INSTANCE_ID="${1:?Usage: $0 <db-instance-identifier> [--fix]}"
FIX_FLAG="${2:-}"

echo "[*] Checking PubliclyAccessible flag for $DB_INSTANCE_ID"
PUBLIC=$(aws rds describe-db-instances \
  --db-instance-identifier "$DB_INSTANCE_ID" \
  --query "DBInstances[0].PubliclyAccessible" \
  --output text)

echo "[*] PubliclyAccessible = $PUBLIC"

if [[ "$PUBLIC" == "True" && "$FIX_FLAG" == "--fix" ]]; then
  echo "[!] Instance is publicly accessible. Applying fix..."
  aws rds modify-db-instance \
    --db-instance-identifier "$DB_INSTANCE_ID" \
    --no-publicly-accessible \
    --apply-immediately
  echo "[*] Fix applied. Re-check after the modification completes."
elif [[ "$PUBLIC" == "True" ]]; then
  echo "[!] Finding: RDS instance is publicly accessible. Re-run with --fix to correct it."
else
  echo "[OK] RDS instance is not publicly accessible."
fi
