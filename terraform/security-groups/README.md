# Security groups module (stub)

To implement:
- `sg-ec2-web`: inbound 80/443 from 0.0.0.0/0, inbound 22 from var.admin_ip only
- `sg-rds-db`: inbound DB port (5432/3306) from sg-ec2-web only, no internet access

Outputs needed by other modules: `ec2_sg_id`, `rds_sg_id`.
