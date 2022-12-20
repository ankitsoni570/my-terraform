# AWS access keys
access_key=""
secret_key=""
region = "us-east-1"

#==========================================================================
#==========================================================================
# Varibale for VPC

vpc_cidr="10.0.0.0/16"
vpc_name="po_test_vpc"

#==========================================================================
#==========================================================================
# Varibale for Subnets

/*pvt_subnet_cidr="10.0.1.0/24"
pvt_availability_zone="us-east-1a"
pub_subnet_cidr="10.0.2.0/24"
pub_availability_zone="us-east-1a"
*/

pvt_subnet_cidr=["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
#pvt_availability_zone="us-east-1a"                                     use if only single zone is required
pub_subnet_cidr=["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
#pub_availability_zone="us-east-1a"                                     use if only single zone is required
availability_zone=["us-east-1a","us-east-1b","us-east-1c"]             #use if pre-defined list of zone is needed
pvt_subnet_name="po-test-private-subnet"
pub_subnet_name="po-test-public-subnet"
nat_gateway_name="po-test-nat-gateway"
int_gateway_name="po-test-Internet-Gateway"
pvt_route_table_name="po-test-pvt-route-table"
pub_route_table_name="po-test-pub-route-table"
nat_gateway_eip_name="po-test-nat-gateway-eip"

#==============================================================================
#==============================================================================
# Calling BLR AGENT EC2

# blr_agent_count=1
# blr_agent_ami="ami-08bcca76f90fdddc4" # "ami-01397df332da9b2ff" #"ami-0d9de6258e941b4f4"
# blr_agent_instance_type="t3.medium"

#==============================================================================
#==============================================================================
# Solr EC2

solr_vm_count=1
solr_vm_instance_type="t2.medium"
bastion_vm_instance_type="t2.medium"
solr_vm_root_volume=50 #Number in GBs
solr_vm_additional_volume=50 #Number in GBs
bastion_vm_root_volume=30 #Number in GBs
#bastion_vm_additional_volume=50 #Number in GBs
root_volume_type="gp3"
root_vol_delete_on_termination=true

dns_domain_name="hi.zone"
dns_record_name="po-solr.hi.zone"

solr_instance_name="po-solr-instance"
bastion_instance_name="po-bastion-instance"
solr_root_volume_name="po-solr-root-volume"
solr_additional_volume_name="po-solr-add-volume"
bastion_root_volume_name="po-bastion-root-volume"
bastion_additional_volume_name="po-bastion-add-volume"
lb_name="po-solr-alb"
tg_name="po-solr-tg"
solr_sg_name="po-solr-sg"
bastion_sg_name="po-bastion-solr-sg"
lb_sg_name="po-solr-alb-sg"
eip_solr_vm_name="po-solr-eip"
eip_bastion_vm_name="po-bastion-eip"

#==============================================================================
#==============================================================================
# ECR (Elastic registory)
ecr_name="project-orange_test_1"
image_tag_mutability="MUTABLE"

#==============================================================================
#==============================================================================
# EKS

cluster_name = "demo"
retention_in_days = "30"
kubernetes_version = "1.22"
enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
endpoint_private_access = true
endpoint_public_access = true
cluster_service_ipv4_cidr = null
map_users = [
    {
      userarn  = "arn:aws:iam::066901814711:user/vtalegaonkar"
      username = "vtalegaonkar"
      groups   = ["system:masters", "system:nodes", "eks-console-dashboard-full-access-group"]
    },
  ]
#------------
# Linux Nodes Variable

linux_node_group_name = "po-linux-nodes"
ami_type = null
capacity_type = null
disk_size = 30
force_update_version = false
instance_types = ["t3.large"]
release_version = null
# ec2_ssh_key  = null
source_security_group_ids = []
desired_size = 3
max_size = 3
min_size = 2

#------------
# Windows Nodes Variable

kubelet_extra_args  = "--register-with-taints='os=windows:NoSchedule'"
lt_name = "po-win-nodes"
win_instance_type = "t3.large"
volume_size = "60"
asg_name = "DEMO"
win_desired_capacity = 3
win_min_size = 2
win_max_size = 3

# ========================================================================================
# ========================================================================================
# Redis Cluster

redis_cluster_name = "po-test-cluster"
redis_node_type = "cache.t2.small"
redis_num_node_grp = 1
replicas_per_node_group = 1
redis_parameter_group = "default.redis6.x"  #It depends on redis version
redis_engine_ver = "6.x" 
redis_multi_az_enabled = false
redis_auto_failover = true
redis_subnet_grp_name = "po-redis-subnet-grp"
redis_sg_name = "po-redis-sg"

#==============================================================================
#==============================================================================
# RDS - SQL Server

sql_server_name = "po-sql-server"
sql_instance_class = "db.t3.large" #"db.r5.large"
sql_allocated_size = 20
sql_max_allocated_size = 1000
sql_storage_type = "gp2"
sql_engine = "sqlserver-ex" 
#sqlserver-ee = Enterprise Edition , sqlserver-se = Standard Edition, sqlserver-ex = Express Edition, sqlserver-web = Web Edition
# Refrence Link = https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html , https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-reqs-limits-MS.html
sql_engine_ver = "15.00.4198.2.v1"
sql_db_user = "admin"
sql_db_pass = "PassW0rd123" # Only printable ASCII characters besides '/', '@', '"', ' ' may be used.
license_model = "license-included"
sql_accessibility = false
sql_multi_az = false
skip_final_snapshot = true
sql_subnet_grp_name = "po-sql-subnet-group"
sql_sg_name = "po-sql-server-sg"

#==============================================================================
#==============================================================================
# RDS - SQL Server
acm_name = "hi-zone-cert"
