data "aws_ami" "windows" {
  most_recent = true

filter {
  name   = "name"
  values = ["Windows_Server-2019-English-Full-Base-*"]
}

owners = ["amazon"]
}
/*
data "aws_availability_zones" "az" {}
*/
