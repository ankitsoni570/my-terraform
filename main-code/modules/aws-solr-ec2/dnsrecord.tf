resource "aws_route53_record" "dnsrecord" {
  count = var.solr_vm_count == 1 ? 1 : 0
  zone_id = aws_route53_zone.dnszone[count.index].zone_id
  name    = var.dns_record_name
  type    = "A"
  ttl     = "300"
  records = aws_instance.solr_instance[*].private_ip
}
