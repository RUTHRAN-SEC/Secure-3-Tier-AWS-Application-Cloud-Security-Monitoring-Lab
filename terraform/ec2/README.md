# EC2 module (stub)

To implement:
- `aws_instance` (Free Tier eligible type, see variables.tf)
- Placed in the public subnet
- Attached to `sg-ec2-web`
- Attached to a scoped IAM instance profile (see ../iam), NOT AdministratorAccess
- CloudWatch agent installed via user_data for log shipping
