variable "vpc_id" {}
variable "pub_subnet_id" {}
variable "pvt_subnet_id" {}

variable "sub_count" {
  default = 3
}
#------
variable "cluster_name" {}
variable "retention_in_days" {}
# variable "region" {
#   type        = string
#   description = "AWS Region"
#   default     = "ap-south-1"
# }

variable "kubernetes_version" {}
variable "endpoint_private_access" {}
variable "endpoint_public_access" {}
variable "enabled_cluster_log_types" {}
variable "cluster_service_ipv4_cidr" {}

# variable "cluster_create_timeout" {
#   description = "Timeout value when creating the EKS cluster."
#   type        = string
#   default     = "30m"
# }

# variable "cluster_delete_timeout" {
#   description = "Timeout value when deleting the EKS cluster."
#   type        = string
#   default     = "15m"
# }
variable "map_users" {}

###############linux node########

variable "linux_node_group_name" {}

# variable "lt_id" {
#   description = "lt_id of the eks linux node group"
#   type        = string
#   default     =  null
# }

# variable "lt_version" {
#   description = "lt_version of the eks linux node group"
#   type        = string
#   default     =  null
# } 

variable "ami_type" {}
variable "capacity_type" {}
variable "disk_size" {}
variable "force_update_version" {}
variable "instance_types" {}
variable "release_version" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}

# variable "lt_config" {
#   type        = list(map(string))
#   description = " Lauch template configuration . Eg: [{ id = `value` , name = `value` , version = `value` }]"
#   default     = []
# }

# variable "ec2_ssh_key" {}
variable "source_security_group_ids" {}

#############Windows Nodes###########

variable "win_instance_type" {}
variable "win_desired_capacity" {}
variable "win_min_size" {}
variable "win_max_size" {}
variable "lt_name" {}
variable "asg_name" {}
variable "volume_size" {}
variable "kubelet_extra_args" {
  description = "This will make sure to taint your nodes at the boot time to avoid scheduling any existing resources in the new Windows worker nodes"
  type        = string
  default     = "--register-with-taints='os=windows:NoSchedule'"
}