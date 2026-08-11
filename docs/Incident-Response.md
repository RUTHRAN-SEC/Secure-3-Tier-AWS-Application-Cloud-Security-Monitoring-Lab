# Incident Response & Automation

## Automated response pipeline

```
CloudTrail / Event
        │
        ▼
     Lambda
        │
        ▼
       SNS
        │
        ▼
 Security Alert (email/SMS)
```

Example flow:
```
Suspicious AWS activity → Detection (CloudWatch Alarm) → Lambda (triggered by alarm/EventBridge) → SNS notification
```

## What the Lambda function does

- Triggered by an EventBridge rule (on a specific CloudTrail event) or a CloudWatch Alarm state change.
- Parses the event to extract actor, action, resource, and time.
- Publishes a formatted message to an SNS topic.
- (Optional stretch goal) Takes a mitigating action automatically — e.g. revoking a security group rule that opened SSH to `0.0.0.0/0`.

## SNS

- Topic subscribed by email (free) for alert delivery.
- Keep the message format consistent so alerts are easy to scan:
  ```
  [ALERT] <scenario> detected
  Actor: <arn>
  Action: <eventName>
  Source IP: <ip>
  Time: <timestamp>
  Resource: <resource>
  ```

## Manual response steps (when not automated)

1. Acknowledge the alert.
2. Confirm scope — is anything actually compromised, or is this the controlled test scenario?
3. Contain — e.g. tighten the security group, rotate any exposed credentials.
4. Eradicate — remove any unauthorized IAM changes.
5. Recover — confirm the environment matches the intended secure baseline.
6. Document — update `Hardening.md` and `Lessons-Learned.md`.
