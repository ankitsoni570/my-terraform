# Creating Security Group for solr instance
resource "aws_security_group" "solr_lb_sg" {
  count = var.solr_vm_count == 1 ? 0 : 1
  name = var.lb_sg_name
  description = var.lb_sg_name
  ingress {
    from_port = 0
    to_port = 0
    protocol = "ALL"
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
    Name = var.lb_sg_name
  }
}
