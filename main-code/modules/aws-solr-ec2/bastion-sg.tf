# Creating Security Group for B&R Agent
resource "aws_security_group" "bastion_sg" {
  count = 1
  name = var.bastion_sg_name
  description = var.bastion_sg_name
  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id
  tags = {
    Name = var.bastion_sg_name
  }
}
