output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [for i in aws_subnet.public : i.id]
}

output "private_subnets" {
  value = [for i in aws_subnet.private : i.id]
}
