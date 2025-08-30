data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "this" {
  ami                         = data.aws_ssm_parameter.al2023.value
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  user_data                   = templatefile("${path.module}/user_data.tpl", {})

  tags = {
    Name = "ansys-interview-ec2"
  }
}

resource "aws_security_group" "http" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface_sg_attachment" "http_attach" {
  security_group_id    = aws_security_group.http.id
  network_interface_id = aws_instance.this.primary_network_interface_id
}
