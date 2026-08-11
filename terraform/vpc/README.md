# VPC module (stub)

To implement:
- `aws_vpc` (10.0.0.0/16)
- `aws_subnet` public (10.0.1.0/24) + private (10.0.2.0/24)
- `aws_internet_gateway`
- `aws_route_table` + association for the public subnet (route to IGW)
- Private subnet: no route to the internet (no NAT, to stay free)

Outputs needed by other modules: `vpc_id`, `public_subnet_id`, `private_subnet_id`.
