# Detection Engineering

## CloudTrail vs CloudWatch

- **CloudTrail** → What happened in AWS? (account/API activity: IAM, EC2, S3 calls)
- **CloudWatch** → What is happening with my resources/applications? (metrics, logs, health)

## Detections mapped to scenarios

| Scenario | Log source | Detection method |
|---|---|---|
| A — Suspicious IAM activity | CloudTrail | CloudWatch Logs metric filter on sensitive `eventName`s (e.g. `CreateUser`, `AttachUserPolicy`, `PutUserPolicy`) → CloudWatch Alarm |
| B — Excessive failed access attempts | CloudTrail (`ConsoleLogin` failures) / EC2 auth logs | Metric filter counting failures within a time window → Alarm above threshold |
| C — Public database exposure | AWS Config / manual audit | Config rule `rds-instance-public-access-check`, or scheduled Lambda check |

## Investigation workflow

For every alert:
1. Identify the actor (`userIdentity.arn`, access key vs. role).
2. Identify the action (`eventName`, `eventSource`).
3. Identify the source (`sourceIPAddress`, `userAgent`).
4. Identify the affected resource (`requestParameters`, `resources`).
5. Determine authorization — was this expected, scheduled, or performed by a known person/process?
6. Classify: benign / needs follow-up / confirmed incident.
7. Record findings (this doc or a dated investigation note).

## Evidence

Store raw CloudTrail event JSON snippets and CloudWatch screenshots under `screenshots/` and reference them here, e.g.:

```
screenshots/scenario-a-cloudtrail-event.png
screenshots/scenario-b-cloudwatch-alarm.png
screenshots/scenario-c-before-after.png
```
