# Architecture

## 1. Overview

This lab implements a segmented 3-tier architecture inside a single VPC, kept intentionally small to stay within AWS Free Tier limits.

```
                    INTERNET
                       │
                       ▼
                ┌───────────────────┐
                │ Internet Gateway  │
                └─────────┬─────────┘
                          │
                   ┌──────▼──────┐
                   │     VPC     │
                   │ 10.0.0.0/16 │
                   └──────┬──────┘
                          │
             ┌────────────┴────────────┐
             │                         │
             ▼                         ▼
     ┌───────────────┐        ┌────────────────┐
     │ Public Subnet │        │ Private Subnet │
     │ 10.0.1.0/24   │        │ 10.0.2.0/24    │
     │               │        │                │
     │ EC2 (Web/App) │───────►│ RDS (Database) │
     └───────┬───────┘        └────────────────┘
             │
      ┌──────┴───────┐
      ▼              ▼
 CloudWatch     CloudTrail
      │              │
      └──────┬───────┘
             ▼
   Security Monitoring
             │
             ▼
     Lambda + SNS → Security Alert
```

## 2. Why "3-tier"

| Tier | Role | Implementation here | Production equivalent |
|---|---|---|---|
| 1 — Presentation | Web-facing component | EC2 | ALB + Auto Scaling group |
| 2 — Application | Business logic | Same EC2 instance (combined for cost) | Dedicated app servers |
| 3 — Database | Data persistence | RDS, private subnet only | RDS Multi-AZ |

## 3. Network design

```
VPC 10.0.0.0/16
├── Public Subnet  10.0.1.0/24   → EC2
└── Private Subnet 10.0.2.0/24   → RDS
```

- The public subnet routes to the internet via the Internet Gateway.
- The private subnet has **no route to the internet** — RDS is never directly reachable from outside the VPC.
- This is the core concept being demonstrated: **network segmentation**.

## 4. Security group model

**EC2 security group**
- Inbound HTTP/HTTPS from the internet.
- Inbound SSH restricted to a single known IP (not `0.0.0.0/0`).

**RDS security group**
- Inbound database port allowed **only** from the EC2 security group — never from the internet.

## 5. Logging & monitoring split

| Service | Answers |
|---|---|
| CloudTrail | "What happened in AWS?" — API/account activity (IAM, EC2, S3, etc.) |
| CloudWatch | "What is happening with my resources?" — CPU, network, logs, health |

## 6. Production comparison

The lab intentionally omits expensive, always-on production components. They're documented here for the portfolio narrative but **not deployed**, to keep cost at zero.

```
INTERNET → Route 53 → WAF → ALB → EC2 (AZ-1) / EC2 (AZ-2) → RDS Multi-AZ
```

| Component | Production purpose | In this lab? |
|---|---|---|
| Route 53 | DNS | No |
| WAF | Web application protection | No |
| ALB | Load balancing | No |
| Auto Scaling | Automatic scaling | No |
| NAT Gateway | Private outbound internet | No (costs money; documented only) |
| RDS Multi-AZ | Database high availability | No (single-AZ, free-tier eligible instance) |
| Security Groups | Network access control | **Yes** |
| IAM | Identity/access control | **Yes** |

## 7. Cost-control notes

- Use only Free Tier eligible instance types (e.g. `t2.micro` / `t3.micro`, `db.t3.micro` for RDS where eligible).
- Set an AWS Budget + billing alarm at a low threshold ($1) before deploying anything.
- Tear down (`terraform destroy`) resources when not actively working on the lab.
- Avoid NAT Gateway (hourly + data charges) — not required for this lab's learning goals.
