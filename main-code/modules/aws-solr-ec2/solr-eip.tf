/*
resource "aws_eip" "eip_solr_ec2" {
  count = var.solr_vm_count == 1 ? 1 : 0
  instance = aws_instance.solr_instance_standalone[count.index].id
  vpc = true

  tags = {
    Name = var.eip_solr_vm_name
  }

#   lifecycle {
#     prevent_destroy = false
#   }
}

resource "aws_eip_association" "eip_assoc" {
  count = var.solr_vm_count == 1 ? 1 : 0
  instance_id   = aws_instance.solr_instance_standalone[count.index].id
  allocation_id = aws_eip.eip_solr_ec2[count.index].id
}
*/