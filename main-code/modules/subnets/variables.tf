variable "vpc_id" {}

variable "pvt_subnet_cidr" {}
#variable "pvt_availability_zone" {}

variable "pub_subnet_cidr" {}
#variable "pub_availability_zone" {}

variable "availability_zone" {}

variable "pvt_subnet_name" {}
variable "pub_subnet_name" {}
variable "nat_gateway_name" {}
variable "int_gateway_name" {}
variable "pvt_route_table_name" {}
variable "pub_route_table_name" {}
variable "nat_gateway_eip_name" {}

variable "cluster_name" {}