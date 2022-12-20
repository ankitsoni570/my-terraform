#if (var.solr_vm_count="1"){
resource "aws_lb_target_group" "solr_tg" {
  count = var.solr_vm_count != 1 ? 1 : 0
  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
  }
  name     = "solr-lb-tg"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  tags = {
    Name = var.tg_name
  }
}


#Target group attachment
resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  count = var.solr_vm_count == 1 ? 0 : var.solr_vm_count
  #count = length(aws_instance.solr_instance)
  target_group_arn = aws_lb_target_group.solr_tg[0].arn
  target_id        = aws_instance.solr_instance[count.index].id
  port             = 443
}
