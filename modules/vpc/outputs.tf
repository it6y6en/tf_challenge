output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for i in aws_subnet.public : i.id]
}

output "private_subnet_ids" {
  value = [for i in aws_subnet.private : i.id]
}
