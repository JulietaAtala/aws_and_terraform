
resource "aws_vpc" "red_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = merge(local.tags, {
    Name = "${var.project_id}-01-vpc"
  })
}

resource "aws_internet_gateway" "red_igw" {
  vpc_id = aws_vpc.red_vpc.id
  tags = merge(local.tags, {
    Name = "${var.project_id}-01-igw"
  })
}

resource "aws_subnet" "red_public_a" {
  vpc_id            = aws_vpc.red_vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "us-east-1a"
  tags = merge(local.tags, {
    Name = "${var.project_id}-01-subnet-public-a"
  })
}


resource "aws_subnet" "red_public_b" {
  vpc_id            = aws_vpc.red_vpc.id
  cidr_block        = var.public_subnet_b_cidr
  availability_zone = "us-east-1b"
  tags = merge(local.tags, {
    Name = "${var.project_id}-01-subnet-public-b"
  })
}

resource "aws_subnet" "red_public_c" {
  vpc_id            = aws_vpc.red_vpc.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = "us-east-1c"
  tags = merge(local.tags, {
    Name = "${var.project_id}-01-subnet-public-c"
  })
}

resource "aws_route_table" "red_rt" {
  vpc_id = aws_vpc.red_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.red_igw.id
  }
  tags = merge(local.tags, {
    Name = "${var.project_id}-01-rt"
  })
}

resource "aws_route_table_association" "red_rta_a" {
  subnet_id      = aws_subnet.red_public_a.id
  route_table_id = aws_route_table.red_rt.id
}

resource "aws_route_table_association" "red_rta_b" {
  subnet_id      = aws_subnet.red_public_b.id
  route_table_id = aws_route_table.red_rt.id
}

resource "aws_route_table_association" "red_rta_c" {
  subnet_id      = aws_subnet.red_public_c.id
  route_table_id = aws_route_table.red_rt.id
}