terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#==============================================================================
#==============================================================================
# Calling VPC Module

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

#==============================================================================
#==============================================================================
# Calling Subnet Module

module "subnets" {
  source = "./modules/subnets"
  vpc_id = "${module.vpc.vpc_id}"
  pvt_subnet_cidr = var.pvt_subnet_cidr
#  pvt_availability_zone = var.pvt_availability_zone     use if only single zone is required
  pub_subnet_cidr = var.pub_subnet_cidr
#  pub_availability_zone = var.pub_availability_zone     use if only single zone is required
  availability_zone = var.availability_zone           #  use if pre-defined list of zone is needed
  pvt_subnet_name = var.pvt_subnet_name
  pub_subnet_name = var.pub_subnet_name
  nat_gateway_name = var.nat_gateway_name
  int_gateway_name = var.int_gateway_name
  pvt_route_table_name = var.pvt_route_table_name
  pub_route_table_name = var.pub_route_table_name
  nat_gateway_eip_name = var.nat_gateway_eip_name
  cluster_name = var.cluster_name   # Enable only if you are creating a kuberntes cluster
}

#==============================================================================
#==============================================================================
# Calling BLR AGENT EC2

module "blr-agent" {
  source = "./modules/aws-agent-ec2"
  blr_agent_count = var.blr_agent_count
  blr_agent_ami = var.blr_agent_ami
  blr_agent_instance_type = var.blr_agent_instance_type
}



#==============================================================================
#==============================================================================
# Calling solr instance

module "aws-solr-ec2" {
  source = "./modules/aws-solr-ec2"
  vpc_id = "${module.vpc.vpc_id}"
  #pvt_subnet_cidr = "${module.subnets.aws_subnet.po-pvt-subnet[count.index].id}"
  solr_vm_instance_type = var.solr_vm_instance_type
  bastion_vm_instance_type = var.bastion_vm_instance_type
  solr_vm_count = var.solr_vm_count
  availability_zone = var.availability_zone
  pub_subnet_id = "${module.subnets.pub_subnet_id}"
  pvt_subnet_id = "${module.subnets.pvt_subnet_id}"
  solr_vm_root_volume = var.solr_vm_root_volume
  solr_vm_additional_volume = var.solr_vm_additional_volume
  bastion_vm_root_volume = var.bastion_vm_root_volume
  #bastion_vm_additional_volume = var.bastion_vm_additional_volume
  
  dns_domain_name = var.dns_domain_name
  dns_record_name = var.dns_record_name

  root_volume_type = var.root_volume_type
  root_vol_delete_on_termination = var.root_vol_delete_on_termination
  solr_instance_name = var.solr_instance_name
  bastion_instance_name = var.bastion_instance_name
  solr_root_volume_name = var.solr_root_volume_name
  solr_additional_volume_name = var.solr_additional_volume_name
  bastion_root_volume_name = var.bastion_root_volume_name
  bastion_additional_volume_name = var.bastion_additional_volume_name
  lb_name = var.lb_name
  tg_name = var.tg_name
  solr_sg_name = var.solr_sg_name
  bastion_sg_name = var.bastion_sg_name
  lb_sg_name = var.lb_sg_name
  eip_solr_vm_name = var.eip_solr_vm_name
  eip_bastion_vm_name = var.eip_bastion_vm_name
}

#==============================================================================
#==============================================================================
# Calling ecr module

module "ecr" {
  source = "./modules/ecr"
  ecr_name = var.ecr_name
  image_tag_mutability = var.image_tag_mutability
}

#==============================================================================
#==============================================================================
# Calling EKS module
module "eks-cluster" {
  source = "./modules/cluster"
  vpc_id = "${module.vpc.vpc_id}"
  pub_subnet_id = "${module.subnets.pub_subnet_id}"
  pvt_subnet_id = "${module.subnets.pvt_subnet_id}"
  #--eks
  cluster_name = var.cluster_name
  retention_in_days = var.retention_in_days
  kubernetes_version = var.kubernetes_version
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access = var.endpoint_public_access
  enabled_cluster_log_types = var.enabled_cluster_log_types
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  map_users = var.map_users
  #--linux-node
  linux_node_group_name = var.linux_node_group_name
  ami_type = var.ami_type
  capacity_type = var.capacity_type
  disk_size = var.disk_size
  force_update_version = var.force_update_version
  instance_types = var.instance_types
  release_version = var.release_version
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size
  # ec2_ssh_key = var.ec2_ssh_key
  source_security_group_ids = var.source_security_group_ids
  #--win-node
  win_instance_type = var.win_instance_type
  win_desired_capacity = var.win_desired_capacity
  win_min_size = var.win_min_size
  win_max_size = var.win_max_size
  lt_name = var.lt_name
  asg_name = var.asg_name
  volume_size = var.volume_size
  kubelet_extra_args = var.kubelet_extra_args
}

#==============================================================================
#==============================================================================
# Calling Redis module
module "redis-cluster" {
  source = "./modules/redis-cluster"
  vpc_id = "${module.vpc.vpc_id}"
  pvt_subnet_id = "${module.subnets.pvt_subnet_id}"
  redis_cluster_name = var.redis_cluster_name
  redis_node_type = var.redis_node_type
  redis_num_node_grp = var.redis_num_node_grp
  replicas_per_node_group = var.replicas_per_node_group
  redis_parameter_group = var.redis_parameter_group
  redis_engine_ver = var.redis_engine_ver
  redis_multi_az_enabled = var.redis_multi_az_enabled
  redis_auto_failover = var.redis_auto_failover
  redis_subnet_grp_name = var.redis_subnet_grp_name
  redis_sg_name = var.redis_sg_name
}

#==============================================================================
#==============================================================================
# Calling RDS - SQL Server module
module "rds-sql" {
  source = "./modules/rds-sql-server"
  vpc_id = "${module.vpc.vpc_id}"
  pvt_subnet_id = "${module.subnets.pvt_subnet_id}"
  sql_server_name = var.sql_server_name
  sql_instance_class = var.sql_instance_class
  sql_allocated_size = var.sql_allocated_size
  sql_max_allocated_size = var.sql_max_allocated_size
  sql_storage_type = var.sql_storage_type
  sql_engine = var.sql_engine
  sql_engine_ver = var.sql_engine_ver
  sql_db_user = var.sql_db_user
  sql_db_pass = var.sql_db_pass
  license_model = var.license_model
  sql_accessibility = var.sql_accessibility
  sql_multi_az = var.sql_multi_az
  skip_final_snapshot = var.skip_final_snapshot
  sql_subnet_grp_name = var.sql_subnet_grp_name
  sql_sg_name = var.sql_sg_name
}

#==============================================================================
#==============================================================================
# Calling ACM
module "acm" {
  source = "./modules/acm"
  acm_name = var.acm_name
}