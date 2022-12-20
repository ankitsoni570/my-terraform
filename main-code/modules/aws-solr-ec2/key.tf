resource "tls_private_key" "pvt_key_solr_ec2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp_solr_ec2" {
  key_name   = "solr_ec2_key"
  public_key = tls_private_key.pvt_key_solr_ec2.public_key_openssh

  # provisioner "local-exec" {
  #   command = "echo '${tls_private_key.pvt_key_solr_ec2.private_key_pem}' > ./myKey1.pem"
  # }
}
resource "local_file" "solr_ssh_key" {
  filename = "${aws_key_pair.kp_solr_ec2.key_name}.pem"
  content = tls_private_key.pvt_key_solr_ec2.private_key_pem
}
