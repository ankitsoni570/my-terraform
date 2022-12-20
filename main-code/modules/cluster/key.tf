resource "tls_private_key" "pvt_key_bnr_agent" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "node-key" {
  key_name   = "po-nodes-key"
  public_key = tls_private_key.pvt_key_bnr_agent.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pvt_key_bnr_agent.private_key_pem}' > ./myKey.pem"
  }
}
resource "local_file" "bnr_ssh_key" {
  filename = "${aws_key_pair.node-key.key_name}.pem"
  content = tls_private_key.pvt_key_bnr_agent.private_key_pem
}