resource "aws_elasticache_replication_group" "redis-cluster" {
  replication_group_id          = var.redis_cluster_name
  replication_group_description = "Redis cluster for Sitecore"
  engine                        = "redis"
  engine_version                = var.redis_engine_ver
  node_type                     = var.redis_node_type
  port                          = 6379
  parameter_group_name          = var.redis_parameter_group
  security_group_ids            = [aws_security_group.redis_sg.id]
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_grp.name
  multi_az_enabled              = var.redis_multi_az_enabled
  automatic_failover_enabled    = var.redis_auto_failover
  auto_minor_version_upgrade    = false
#   snapshot_retention_limit    = 5

  cluster_mode {
    num_node_groups            = var.redis_num_node_grp
    replicas_per_node_group    = var.replicas_per_node_group
  }

}

resource "aws_elasticache_subnet_group" "redis_subnet_grp" {
  name       = var.redis_subnet_grp_name
  subnet_ids = var.pvt_subnet_id
}
