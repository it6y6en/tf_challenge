data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = data.aws_availability_zones.available.names
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "ansys-interview"
  }
}

resource "aws_subnet" "public" {
  for_each          = { for i in range(var.num_public_subnets) : "public-${i}" => i }
  vpc_id            = aws_vpc.this.id
  availability_zone = local.azs[each.value % length(local.azs)]
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, each.value)

  tags = {
    Name = "ansys-interview-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each          = { for i in range(var.num_public_subnets) : "private-${i}" => i }
  vpc_id            = aws_vpc.this.id
  availability_zone = local.azs[each.value % length(local.azs)]
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, each.value + length(local.azs))

  tags = {
    Name = "ansys-interview-${each.key}"
  }
}
