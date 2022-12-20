#---------Private Route Table--------
resource "aws_route_table" "po-pvt-route-table" {
  vpc_id = var.vpc_id
  count = length(var.pvt_subnet_cidr)

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.po-ngw[count.index].id
  }

  tags = {
    Name = "${var.pvt_route_table_name}-${count.index}"
  }

}
resource "aws_route_table_association" "po-pvt-route-table-association" {
  count = length(var.pvt_subnet_cidr)
  route_table_id = aws_route_table.po-pvt-route-table[count.index].id
  subnet_id      = aws_subnet.po-pvt-subnet[count.index].id
}


#--------Public Route Table------

resource "aws_route_table" "po-pub-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.po-igw.id
  }

  tags = {
    Name = var.pub_route_table_name
  }

}
resource "aws_route_table_association" "po-pub-route-table-association" {
  count = length(var.pub_subnet_cidr)
  route_table_id = aws_route_table.po-pub-route-table.id
  subnet_id      = aws_subnet.po-pub-subnet[count.index].id
}



# ----- Version 1
/*
#---------Private Route Table--------
resource "aws_route_table" "po-pvt-route-table-1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.po-ngw-1.id
  }

  tags = {
    Name = "po-pvt-route-table-1"
  }

}
resource "aws_route_table" "po-pvt-route-table-2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.po-ngw-2.id
  }

  tags = {
    Name = "po-pvt-route-table-2"
  }

}
resource "aws_route_table" "po-pvt-route-table-3" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.po-ngw-3.id
  }

  tags = {
    Name = "po-pvt-route-table-3"
  }

}
resource "aws_route_table_association" "po-pvt-route-table-association-1" {
  route_table_id = aws_route_table.po-pvt-route-table-1.id
  subnet_id      = aws_subnet.po-pvt-subnet-1.id
}
resource "aws_route_table_association" "po-pvt-route-table-association-2" {
  route_table_id = aws_route_table.po-pvt-route-table-2.id
  subnet_id      = aws_subnet.po-pvt-subnet-2.id
}
resource "aws_route_table_association" "po-pvt-route-table-association-3" {
  route_table_id = aws_route_table.po-pvt-route-table-3.id
  subnet_id      = aws_subnet.po-pvt-subnet-3.id
}


#--------Public Route Table------


resource "aws_route_table" "po-pub-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.po-igw.id
  }

  tags = {
    Name = "po-pub-route-table"
  }

}
resource "aws_route_table_association" "po-pub-route-table-association-1" {
  route_table_id = aws_route_table.po-pub-route-table.id
  subnet_id      = aws_subnet.po-pub-subnet-1.id
}
resource "aws_route_table_association" "po-pub-route-table-association-2" {
  route_table_id = aws_route_table.po-pub-route-table.id
  subnet_id      = aws_subnet.po-pub-subnet-2.id
}
resource "aws_route_table_association" "po-pub-route-table-association-3" {
  route_table_id = aws_route_table.po-pub-route-table.id
  subnet_id      = aws_subnet.po-pub-subnet-3.id
}
*/