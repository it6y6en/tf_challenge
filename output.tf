output "ec2_public_url" {
  value = "http://${module.ec2.public_ip}:80"
}