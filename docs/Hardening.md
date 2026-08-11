# Hardening — Before / After

Track each fix applied as a result of a threat scenario or audit finding.

## Template

```
### <Finding name>
- **Before:** <insecure configuration>
- **Risk:** <why it matters>
- **After:** <fixed configuration>
- **Evidence:** screenshots/<file>.png
```

## Entries

### RDS publicly accessible (Scenario C)
- **Before:** `PubliclyAccessible = true`, reachable from the internet.
- **Risk:** Database directly exposed; bypasses the application tier and its access controls entirely.
- **After:** `PubliclyAccessible = false`; inbound only from `sg-ec2-web`.
- **Evidence:** _add screenshot path here once captured_

### Open SSH (0.0.0.0/0)
- **Before:** Security group allowed inbound `22` from anywhere.
- **Risk:** Exposed to internet-wide brute-force/credential-stuffing attempts.
- **After:** Restricted to a single admin IP, or replaced with SSM Session Manager (no open inbound port).
- **Evidence:** _add screenshot path here once captured_

### Over-privileged EC2 role
- **Before:** `AdministratorAccess` attached to the instance role.
- **Risk:** A compromised instance would grant full account control.
- **After:** Scoped, application-specific policy with only required actions/resources.
- **Evidence:** _add screenshot path here once captured_

_Add further entries as you run more scenarios._
