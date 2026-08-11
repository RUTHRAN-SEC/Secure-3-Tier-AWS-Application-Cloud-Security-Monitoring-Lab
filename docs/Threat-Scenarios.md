# Threat Scenarios

Controlled, self-inflicted scenarios run against the lab environment (never against systems you don't own) to generate realistic logs and practice detection → investigation → response.

## Scenario A — Suspicious IAM activity

```
IAM activity → CloudTrail → Detection → Investigation
```

**Simulation:** Create/modify an IAM policy or user from an unfamiliar context (e.g. a different region or via CLI instead of console) and observe the CloudTrail event.

**Investigation questions:**
- Who performed the action? (`userIdentity` in the CloudTrail event)
- What API call was made? (`eventName`)
- From where? (`sourceIPAddress`)
- When? (`eventTime`)
- Which resource was affected?
- Was it authorized / expected?

## Scenario B — Excessive failed access attempts

```
Repeated access attempts → Logs → Detection → Alert
```

**Simulation:** Repeated failed SSH logins to the EC2 instance, or repeated `ConsoleLogin` failures for an IAM user.

**Investigation questions:**
- Is the source IP known/expected?
- Is this a brute-force pattern (rate, spread of usernames) or a misconfigured client retrying?
- Does it correlate with any successful login shortly after?

## Scenario C — Public database exposure

**Simulation (documented in a controlled lab, not left running):**
```
RDS
 └── Publicly accessible ❌
```

**Detection:** Manually check, or use a scheduled check (e.g. AWS Config rule `rds-instance-public-access-check`), to flag `PubliclyAccessible = true`.

**Fix:**
```
RDS
 └── Private + EC2-only access ✅
```

This scenario produces a clean before/after screenshot pair for the portfolio.

## Logging the scenarios

For each scenario actually run, record in this file (or a dated file under `scripts/detection-scenarios/`):
- Date/time run
- Exact action taken
- CloudTrail/CloudWatch evidence (screenshot path in `screenshots/`)
- Detection method used
- Outcome/remediation
