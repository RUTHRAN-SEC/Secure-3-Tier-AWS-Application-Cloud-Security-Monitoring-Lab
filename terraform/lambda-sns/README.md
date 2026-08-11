# Lambda + SNS module (stub)

To implement:
- `aws_sns_topic` + email subscription for alerts
- `aws_lambda_function` triggered by an EventBridge rule (on specific CloudTrail events) or CloudWatch Alarm state change
- Lambda publishes a formatted alert message to the SNS topic (see docs/Incident-Response.md for message format)
