# AWS access keys
variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}

variable "region" {
  type = string
}
#==========================================================================
#==========================================================================
# Varibale for VPC

variable "vpc_cidr" {
    type = string
}
variable "vpc_name" {
  type = string
}

#==========================================================================
#==========================================================================
# Varibale for Subnets,NAT,IGW,RouteTable

variable "pvt_subnet_cidr" {
    type = list(string)
}
#variable "pvt_availability_zone" {
#    type = string
#}

variable "pub_subnet_cidr" {
    type = list(string)
}
#variable "pub_availability_zone" {
#    type = string
#}
variable "availability_zone" {
    type = list(string)
}
variable "pvt_subnet_name" {
  type = string
}
variable "pub_subnet_name" {
  type = string
}
variable "nat_gateway_name" {
  type = string
}
variable "int_gateway_name" {
  type = string
}
variable "pvt_route_table_name" {
  type = string
}
variable "pub_route_table_name" {
  type = string
}
variable "nat_gateway_eip_name" {
  type = string
}

# #==============================================================================
# #==============================================================================
# # Calling BLR AGENT EC2

# variable "blr_agent_count" {
#     type = number
# }
# variable "blr_agent_ami" {
#     type = string
# }
# variable "blr_agent_instance_type" {
#     type = string
# }
#==============================================================================
#==============================================================================
# Solr & Bastion EC2


variable "solr_vm_count" {
    type = number
}

variable "solr_vm_instance_type" {
    type = string
}
variable "bastion_vm_instance_type" {
  type = string
}

variable "solr_vm_root_volume" {
  type = number
}
variable "solr_vm_additional_volume" {
  type = number
}
variable "bastion_vm_root_volume" {
  type = number
}
#variable "bastion_vm_additional_volume" {
#  type = number
#}
variable "dns_domain_name" {
  type = string
}
variable "dns_record_name" {
  type = string
}
variable "root_volume_type" {
  type = string
}
variable "root_vol_delete_on_termination" {
  type = bool
}
variable "solr_instance_name" {
  type = string
}
variable "bastion_instance_name" {
  type = string
}
variable "solr_root_volume_name" {
  type = string
}
variable "solr_additional_volume_name" {
  type = string
}
variable "bastion_root_volume_name" {
  type = string
}
variable "bastion_additional_volume_name" {
  type = string
}
variable "lb_name" {
  type = string
}
variable "tg_name" {
  type = string
}
variable "solr_sg_name" {
  type = string
}
variable "bastion_sg_name" {
  type = string
}
variable "lb_sg_name" {
  type = string
}
variable "eip_solr_vm_name" {
  type = string
}
variable "eip_bastion_vm_name" {
  type = string
}

#==============================================================================
#==============================================================================
# EKS
#------------
# EKS Variables
variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  # default     = "demo"
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group.(Optional) "
  # default     = "30"
}

variable "kubernetes_version" {
  type        = string
  # default     = "1.22"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  # default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
}

variable "endpoint_private_access" {
  type        = bool
  # default     = true
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled. Default to AWS EKS resource and it is false"
}

variable "endpoint_public_access" {
  type        = bool
  # default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. Default to AWS EKS resource and it is true"
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  # default     = null
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  # default = [
  #   {
  #     userarn  = "arn:aws:iam::66666666666:user/user1"
  #     username = "user1"
  #     groups   = ["system:masters"]
  #   },
  # ]
}

#------------
# Linux Nodes Variable

variable "linux_node_group_name" {
  description = "Name of the linux node group"
  type        = string
  # default     = "DEMO"
}

variable "ami_type" {
  type        = string
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64"
  # default     = null
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the EKS Node Group"
  # default     = null
}

variable "disk_size" {
  type        = number
  description = "Disk size in GiB for worker nodes. Defaults to 20"
  # default     = 30
}

variable "force_update_version" {
  type        = bool
  description = "Force version update if existing pods are unable to be drained"
  # default     = false
}

variable "instance_types" {
  type        = list(any)
  description = "List of instance types associated with the EKS Node Group"
  # default     = ["t3.medium"]
}

variable "release_version" {
  type        = string
  description = "AMI version of the EKS Node Group"
  # default     = null
}

# variable "ec2_ssh_key" {
#   description = " ssh key for ec2"
#   default     = null
# }

variable "source_security_group_ids" {
  description = "source_security_group_ids for remote access"
  # default     = []
}

variable "desired_size" {
  description = "desired linux instance count"
  type        = number
  # default     = 1
}

variable "max_size" {
  description = "minimum linux instance count"
  type        = number
  # default     = 2
}

variable "min_size" {
  description = "maximum linux instance count"
  type        = number
  # default     = 1
}

#------------
# Windows Nodes Variable

variable "kubelet_extra_args" {
  description = "This will make sure to taint your nodes at the boot time to avoid scheduling any existing resources in the new Windows worker nodes"
  type        = string
  # default     = "--register-with-taints='os=windows:NoSchedule'"
}

variable "lt_name" {
  description = "Name of the LT"
  type        = string
  # default     = "DEMO"
}

variable "win_instance_type" {
  description = "Instance type for windows worker nodes"
  type        = string
  # default     = "t3.medium"
}

variable "volume_size" {
  description = "Volume size for EBS root disk"
  type        = string
  # default     = "60"
}

variable "asg_name" {
  description = "The name of the ASG"
  type        = string
  # default     = "DEMO"
}

variable "win_desired_capacity" {
  description = "he number of Amazon EC2 instances that should be running in the group"
  type        = number
  # default     = 1
}

variable "win_min_size" {
  description = "The minimum size of the windows node Auto Scaling Group"
  type        = number
  # default     = 1
}

variable "win_max_size" {
  description = "The maximum size of the windows node Auto Scaling Group"
  type        = number
  # default     = 2
}
# ========================================================================================
# ========================================================================================
# ECR (Elastic registory)

variable "ecr_name" {
  type = string
}

variable "image_tag_mutability" {
  type = string
}

# ========================================================================================
# ========================================================================================
# Redis Cluster

variable "redis_cluster_name" {
  type = string
}
variable "redis_node_type" {
  type = string
}
variable "redis_num_node_grp" {
  type = number
}
variable "replicas_per_node_group" {
  type = number
}
variable "redis_parameter_group" {
  type = string
}
variable "redis_engine_ver" {
  type = string
}
variable "redis_multi_az_enabled" {
  type = bool
}
variable "redis_auto_failover" {
  type = bool
}
variable "redis_subnet_grp_name" {
  type = string
}
variable "redis_sg_name" {
  type = string
}

#==============================================================================
#==============================================================================
# RDS - SQL Server

variable "sql_server_name" {
  type = string
}
variable "sql_instance_class" {
  type = string
}
variable "sql_allocated_size" {
  type = number
}
variable "sql_max_allocated_size" {
  type = number
}
variable "sql_storage_type" {
  type = string
}
variable "sql_engine" {
  type = string
}
variable "sql_engine_ver" {
  type = string
}
variable "sql_db_user" {
  type = string
}
variable "sql_db_pass" {
  type = string
}
variable "license_model" {
  type = string
}
variable "sql_accessibility" {
  type = bool
}
variable "sql_multi_az" {
  type = bool
}
variable "skip_final_snapshot" {
  type = bool
}
variable "sql_subnet_grp_name" {
  type = string
}
variable "sql_sg_name" {
  type = string
}

#==============================================================================
#==============================================================================
# ACM

variable "acm_name" {
  type = string
}