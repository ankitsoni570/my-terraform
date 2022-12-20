resource "aws_route53_zone" "dnszone" {
  count = var.solr_vm_count == 1 ? 1 : 0
  name = var.dns_domain_name


  vpc {
    vpc_id = var.vpc_id
  }

  tags = {
    Name = "${var.dns_domain_name} private hosted zone"
  }
#   lifecycle {
#     ignore_changes = [vpc]
#   }
}

# resource "aws_route53_zone_association" "zone_association" {
#   count = var.solr_vm_count == 1 ? 1 : 0
#   zone_id = aws_route53_zone.dnszone[count.index].zone_id
#   vpc_id  = var.vpc_id
# }
