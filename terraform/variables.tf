variable "aws_region" {
  description = "AWS region to deploy the lab into"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the lab VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "admin_ip" {
  description = "Your IP address (CIDR, e.g. 1.2.3.4/32) allowed to SSH into the EC2 instance. Never use 0.0.0.0/0."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type — keep Free Tier eligible (t2.micro / t3.micro)"
  type        = string
  default     = "t2.micro"
}

variable "db_instance_class" {
  description = "RDS instance class — keep Free Tier eligible (db.t3.micro / db.t2.micro)"
  type        = string
  default     = "db.t3.micro"
}
