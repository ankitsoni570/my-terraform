resource "aws_acm_certificate" "hi-zone-cert" {
  private_key       = file("private.key")
  certificate_body  = file("cert.cer")
  certificate_chain = file("chain.cer")
  tags = {
    name = var.acm_name
  }
}

# Certificate files can be generated using PFX and password. 
# Use https://aws.amazon.com/blogs/security/how-to-import-pfx-formatted-certificates-into-aws-certificate-manager-using-openssl/ to generate yours