# Secure 3-Tier AWS Application & Cloud Security Monitoring Lab

A hands-on AWS cloud engineering and cloud security lab: design, deploy, secure, monitor, attack-test, and harden a segmented 3-tier web application environment — built to stay within AWS Free Tier.

> ⚠️ **Cost note:** This project targets ₹0 / Free Tier usage, but AWS Free Tier eligibility depends on your account (12-month new accounts vs. always-free tiers vs. current AWS promotional offers). **Verify your account's current Free Tier eligibility and set up a billing alarm/budget before creating any resources.** Nothing here is guaranteed permanently free.

## What this is

This repo documents a lab environment that simulates a real production AWS setup:

```
INTERNET → Internet Gateway → VPC (10.0.0.0/16)
                                 ├── Public Subnet (10.0.1.0/24) → EC2 (Web/App tier)
                                 └── Private Subnet (10.0.2.0/24) → RDS (Database tier)

EC2 → CloudWatch + CloudTrail → Security Monitoring → Lambda + SNS → Alert
```

The goal isn't just "launch an EC2 instance" — it's to answer:

> How do I securely deploy an application in AWS, monitor it, detect security problems, investigate them, and automatically respond?

## Repo structure

```
secure-3tier-aws-security-lab/
├── README.md                      This file
├── docs/                          Written deliverables (architecture, security, detection, IR, hardening)
├── diagrams/                      Architecture diagrams (source + exported images)
├── terraform/                     Infrastructure as code, organized by component
│   ├── vpc/
│   ├── security-groups/
│   ├── ec2/
│   ├── rds/
│   ├── iam/
│   └── lambda-sns/
├── scripts/
│   └── detection-scenarios/       Scripts/CLI commands used to simulate attack scenarios
└── screenshots/                   Evidence captures (console, CloudWatch, CloudTrail, alerts)
```

## Project phases

```
DESIGN → DEPLOY → SECURE → MONITOR → ATTACK-TEST → DETECT → INVESTIGATE → RESPOND → HARDEN → DOCUMENT
```

## Documentation index

| File | Purpose |
|---|---|
| [docs/Architecture.md](docs/Architecture.md) | Network + component architecture, free-tier vs. production comparison |
| [docs/Security-Controls.md](docs/Security-Controls.md) | IAM, security groups, network segmentation, secure SSH |
| [docs/Threat-Scenarios.md](docs/Threat-Scenarios.md) | The controlled attack scenarios used to generate detections |
| [docs/Detection-Engineering.md](docs/Detection-Engineering.md) | CloudTrail/CloudWatch detections, investigation steps |
| [docs/Incident-Response.md](docs/Incident-Response.md) | Response workflow, Lambda + SNS automation |
| [docs/Hardening.md](docs/Hardening.md) | Before/after fixes for each scenario |
| [docs/Lessons-Learned.md](docs/Lessons-Learned.md) | Retrospective notes |

## Status

🚧 Planning stage — infrastructure not yet deployed. See `docs/Architecture.md` for the design and `terraform/` for IaC as it's built out.

## License

MIT (or your choice) — update `LICENSE` before publishing.
