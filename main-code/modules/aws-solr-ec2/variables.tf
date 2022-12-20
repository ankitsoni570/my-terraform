variable "vpc_id" {}

#variable "pvt_subnet_cidr" {}

variable "pvt_subnet_id" {}
variable "pub_subnet_id" {}

variable "solr_vm_count" {}
variable "solr_vm_instance_type" {}
variable "bastion_vm_instance_type" {}
variable "availability_zone" {}

variable "solr_vm_root_volume" {}
variable "solr_vm_additional_volume" {}
variable "root_volume_type" {}
variable "root_vol_delete_on_termination" {}

variable "bastion_vm_root_volume" {}

variable "dns_domain_name" {}
variable "dns_record_name" {}

#variable "bastion_vm_additional_volume" {}

variable "solr_instance_name" {}
variable "bastion_instance_name" {}
variable "solr_root_volume_name" {}
variable "solr_additional_volume_name" {}
variable "bastion_root_volume_name" {}
variable "bastion_additional_volume_name" {}
variable "lb_name" {}
variable "tg_name" {}
variable "solr_sg_name" {}
variable "bastion_sg_name" {}
variable "lb_sg_name" {}
variable "eip_solr_vm_name" {}
variable "eip_bastion_vm_name" {}
