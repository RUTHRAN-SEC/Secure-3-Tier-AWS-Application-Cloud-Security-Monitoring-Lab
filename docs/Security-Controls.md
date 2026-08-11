# Security Controls

## 1. IAM — Least Privilege

### Bad configuration (documented as an anti-pattern, not deployed)
```
EC2 → AdministratorAccess
```
Why it's dangerous: a compromised instance would grant an attacker full control of the AWS account, not just the application's resources.

### Better configuration (what this lab deploys)
```
EC2 → Application-specific IAM Role → Only required permissions
```
The EC2 instance role should be scoped to only what the application needs — e.g. reading a specific S3 bucket, writing to a specific CloudWatch log group. No wildcard (`*`) resource permissions on sensitive actions.

### IAM structure used
```
IAM
├── Users     — human access (console/CLI), MFA enforced
├── Groups    — permission sets assigned to users
├── Roles     — assumed by EC2/Lambda, not long-lived credentials
└── Policies  — least-privilege, scoped to specific resources/actions
```

## 2. Network segmentation

- Public subnet: EC2 only.
- Private subnet: RDS only, no route to the internet.
- This ensures the database tier is unreachable except through the application tier.

## 3. Security groups

| Security Group | Inbound rule | Purpose |
|---|---|---|
| `sg-ec2-web` | 80/443 from `0.0.0.0/0` | Serve web traffic |
| `sg-ec2-web` | 22 from `<your IP>/32` | Admin SSH, not open to the world |
| `sg-rds-db` | DB port from `sg-ec2-web` only | Database reachable only from the app tier, never the internet |

## 4. Secure SSH

- No SSH open to `0.0.0.0/0`.
- Restrict to a single admin IP, or better: use **AWS Systems Manager Session Manager** instead of SSH entirely (no open inbound port needed).

## 5. Database isolation

- RDS deployed in the private subnet, `PubliclyAccessible = false`.
- Verified via console/CLI as part of the hardening checklist (see `Threat-Scenarios.md`, Scenario C).

## 6. Logging enabled

- CloudTrail: management + data events logged to an S3 bucket (with bucket encryption + versioning).
- CloudWatch: EC2 metrics, and application/system logs shipped via the CloudWatch agent.

## 7. Checklist

- [ ] MFA enabled on root and IAM users
- [ ] No long-lived access keys used by applications (roles only)
- [ ] No security group allows unrestricted SSH (`22` from `0.0.0.0/0`)
- [ ] RDS `PubliclyAccessible = false`
- [ ] RDS only reachable from the EC2 security group
- [ ] CloudTrail enabled account-wide
- [ ] CloudWatch alarms configured for key metrics
- [ ] Billing alarm configured
