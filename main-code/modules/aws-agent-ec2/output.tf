#Keys output
output "bnr_agent_pub_key" {
  value = aws_key_pair.kp_bnr_agent.public_key
}
output "bnr_agent_pvt_key" {
  value = tls_private_key.pvt_key_bnr_agent.private_key_pem
}