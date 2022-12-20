resource "aws_lb" "solr-alb" {
  count = var.solr_vm_count == 1 ? 0 : 1
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.solr_lb_sg[count.index].id]
  subnets            = var.pub_subnet_id
  ip_address_type = "ipv4"

  enable_deletion_protection = false
  tags = {
    Name = var.lb_name
  }
}
/*
  access_logs {
    bucket  = aws_s3_bucket.s3_logs.solr_alb_logs.id
    prefix  = "test-lb"
    enabled = false
  }

  tags = {
    Environment = "production"
  }
}


resource "aws_s3_bucket" "s3_logs" {
  bucket = "solr_alb_logs"
  #aws_s3_bucket_acl = "public-read-write"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
*/
