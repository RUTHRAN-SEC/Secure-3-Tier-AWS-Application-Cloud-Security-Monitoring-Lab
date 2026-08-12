# Secure 3 Tier AWS Application & Cloud Security Monitoring Lab

A hands on AWS cloud engineering and cloud security lab: design, deploy, secure, monitor, attack-test, and harden a segmented 3-tier web application environment. Built to stay within AWS Free Tier.


## What is This Repo is About 

This repo documents a lab environment that simulates a real production AWS setup:

<img width="1536" height="1024" alt="Copilot_20260811_221857" src="https://github.com/user-attachments/assets/96874db3-a916-447f-8156-47e6fee13838" />

**The goal isn't just "launch an EC2 instance", It's to answer:**
- How do I securely deploy an application in AWS, monitor it, detect security problems, investigate them, and automatically respond?

## Repo structure

```
Secure-3-Tier-AWS-Application-Cloud-Security-Monitoring-Lab/
├── README.md                     
├── docs/                          #Written deliverables (architecture, security, detection, IR, hardening)
├── diagrams/                      #Architecture diagrams (source + exported images)
├── terraform/                     #Infrastructure as code, organized by component
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


### DONE BY 
#### RUTHRAN-SEC
