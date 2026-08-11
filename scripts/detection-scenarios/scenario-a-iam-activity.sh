#!/usr/bin/env bash
# Scenario A — Suspicious IAM activity
# Generates a CloudTrail event by creating and cleaning up a throwaway IAM user.
# Run only in your own lab account. Review docs/Threat-Scenarios.md before running.

set -euo pipefail

USER_NAME="lab-detection-test-user"

echo "[*] Creating throwaway IAM user: $USER_NAME"
aws iam create-user --user-name "$USER_NAME"

echo "[*] Attaching a policy to the user (generates AttachUserPolicy event)"
aws iam attach-user-policy \
  --user-name "$USER_NAME" \
  --policy-arn "arn:aws:iam::aws:policy/ReadOnlyAccess"

echo "[*] Waiting a few seconds for CloudTrail to log the events..."
sleep 5

echo "[*] Cleaning up: detaching policy and deleting the user"
aws iam detach-user-policy \
  --user-name "$USER_NAME" \
  --policy-arn "arn:aws:iam::aws:policy/ReadOnlyAccess"
aws iam delete-user --user-name "$USER_NAME"

echo "[*] Done. Check CloudTrail Event history for CreateUser / AttachUserPolicy / DeleteUser events."
