resource "aws_eip" "eip_bastion_ec2" {
  count = 1
  instance = aws_instance.bastion_instance[count.index].id
  vpc = true

  tags = {
    Name = var.eip_bastion_vm_name
  }

#   lifecycle {
#     prevent_destroy = false
#   }
}

resource "aws_eip_association" "eip_assoc_bastion" {
  count = 1
  instance_id   = aws_instance.bastion_instance[count.index].id
  allocation_id = aws_eip.eip_bastion_ec2[count.index].id
}
