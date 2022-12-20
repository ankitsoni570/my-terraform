resource "aws_eip" "eip_bnr_agent" {
  count = var.blr_agent_count
  instance = "${element(aws_instance.agent_machine.*.id,count.index)}"
  vpc = true
  
  tags = {
    Name = "eip-blr-agent-${count.index}"
  }

#   lifecycle {
#     prevent_destroy = false
#   }
}

resource "aws_eip_association" "eip_assoc" {
  count = var.blr_agent_count
  instance_id   ="${element(aws_instance.agent_machine.*.id,count.index)}"
  allocation_id ="${element(aws_eip.eip_bnr_agent.*.id,count.index)}" #aws_eip.eip_bnr_agent.id
}