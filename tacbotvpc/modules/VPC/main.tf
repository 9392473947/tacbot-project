#VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.owned_tags,
    {
      Name ="${var.projectname}-vpc"
    }
  )
}
#public subnet
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-public-subnet-${count.index}"
    "kubernetes.io/cluster/tacbotinc-eks" = "owned"
    "kubernetes.io/role/elb" = 1
    }
  )
}

#private subnet
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-private-subnet-${count.index}"
    "kubernetes.io/cluster/tacbotinc-eks" = "owned"
    "kubernetes.io/role/internal-elb" = 1
    }
  )
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-igw"
    }
  )
}

#EIP
resource "aws_eip" "eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
}
#NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-nat"
    }
  )
  depends_on = [aws_internet_gateway.igw]
}

#public route table
resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-public-rt"
    }
  )
}

#private route table
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(
    var.owned_tags,
    {
    Name = "${var.projectname}-private-rt"
    }
  )
}

#public route table association
resource "aws_route_table_association" "public-association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.publicrt.id
}

#private route table association
resource "aws_route_table_association" "private-association" {
  count = length(var.private_subnet_cidrs)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.privatert.id  
}


