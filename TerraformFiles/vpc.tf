resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Assessment"
  }
}
resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "pub-1"
  }
}
resource "aws_subnet" "public-1b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "pub-2"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.ZONE1
  tags = {
    Name = "priv-1"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.ZONE2
  tags = {
    Name = "priv-2"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

}
resource "aws_route_table_association" "public-1a" {
  count          = 2
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "public-1b" {
  count          = 2
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public.id

}