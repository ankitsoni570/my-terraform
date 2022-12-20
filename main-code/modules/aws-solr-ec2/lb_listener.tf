resource "aws_lb_listener" "solr_listerner" {
  count = var.solr_vm_count == 1 ? 0 : 1
  load_balancer_arn = aws_lb.solr-alb[count.index].arn
  port              = "80"     #chnage to port443
  protocol          = "HTTP"   #update to https once we hace the certificate
  #ssl_policy        = "ELBSecurityPolicy-2016-08"                                                                #used for 443          
  #certificate_arn   = "arn:aws:acm:us-east-1:295064799264:certificate/bd1a2875-f220-4d77-96cc-a8a1f4e15f40"      #used for 443

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.solr_tg[count.index].arn
  }
}
