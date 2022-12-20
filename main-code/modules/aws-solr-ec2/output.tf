#Keys output
output "solr_ec2_pub_key" {
  value = aws_key_pair.kp_solr_ec2.public_key
}
output "solr_ec2_pvt_key" {
  value = tls_private_key.pvt_key_solr_ec2.private_key_pem
}

output "bastion_instance_id" {
  value = aws_instance.bastion_instance[0].id
}
output "solr_ec2_instance_id" {
  value = aws_instance.solr_instance[*].id
}
# output "solr_standalone_instance_id" {
#   value = aws_instance.solr_instance_standalone[*].id 
# }
# output "solr_ec2_eip_id" {
#   value = aws_eip.eip_solr_ec2[*].id
# }
#output "solr_standalone_ec2_eip_id" {
#  value = aws
#}
output "solr_private_ip" {
  value = aws_instance.solr_instance[*].private_ip
}