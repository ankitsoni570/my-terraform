# ---- version3
#-------Private Subnet---------
resource "aws_subnet" "po-pvt-subnet" {
  count = length(var.pvt_subnet_cidr)
  vpc_id = var.vpc_id
  cidr_block = var.pvt_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "${var.pvt_subnet_name} ${var.availability_zone[count.index]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

#-------Public Subnet---------

resource "aws_subnet" "po-pub-subnet" {
  count = length(var.pub_subnet_cidr)
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "${var.pub_subnet_name} ${var.availability_zone[count.index]}"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}

# ----- version 2
/*
#-------Private Subnet---------
resource "aws_subnet" "po-pvt-subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.pvt_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "PO Private Subnet-1"
  }
}
resource "aws_subnet" "po-pvt-subnet-2" {
  vpc_id = var.vpc_id
  cidr_block = var.pvt_subnet_cidr[1]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "PO Private Subnet-2"
  }
}
resource "aws_subnet" "po-pvt-subnet-3" {
  vpc_id = var.vpc_id
  cidr_block = var.pvt_subnet_cidr[2]
  availability_zone = var.availability_zone[2]
  tags = {
    Name = "PO Private Subnet-3"
  }
}
#-------Public Subnet---------

resource "aws_subnet" "po-pub-subnet-1" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr[0]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "PO Public Subnet-1"
  }
}

resource "aws_subnet" "po-pub-subnet-2" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr[1]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "PO Public Subnet-2"
  }
}

resource "aws_subnet" "po-pub-subnet-3" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr[2]
  availability_zone = var.availability_zone[2]
  tags = {
    Name = "PO Public Subnet-3"
  }
}


# ---- version 1
resource "aws_subnet" "po-pvt-subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.pvt_subnet_cidr
  availability_zone = var.pvt_availability_zone
  tags = {
    Name = "PC Private Subnet"
  }
}

resource "aws_subnet" "po-pub-subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.pub_subnet_cidr
  availability_zone = var.pub_availability_zone
  tags = {
    Name = "PC Public Subnet"
  }
}
*/