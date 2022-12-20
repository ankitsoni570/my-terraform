resource "aws_internet_gateway" "po-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.int_gateway_name
  }
}
