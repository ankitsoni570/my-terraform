resource "aws_cloudwatch_log_group" "cloudwatch_log_grp" {
  name              = var.cluster_name
  retention_in_days = var.retention_in_days
}

resource "aws_iam_role" "cluster_role" {
  name = "eks_cluster_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "cluster_attach" {
  role       = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_role_policy_attachment" "po-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_security_group" "cluster_sg" {
  name        = "cluster_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "po-eks-sg"
  }
}

resource "aws_eks_cluster" "cluster" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.cluster_role.arn
  version                   = var.kubernetes_version
  enabled_cluster_log_types = var.enabled_cluster_log_types
  vpc_config {    
    security_group_ids      = [aws_security_group.cluster_sg.id]
    subnet_ids              = [var.pub_subnet_id[0], var.pub_subnet_id[1], var.pub_subnet_id[2], var.pvt_subnet_id[0], var.pvt_subnet_id[1], var.pvt_subnet_id[2]] #aws_subnet.demo[*].id
    endpoint_private_access = var.endpoint_private_access #false
    endpoint_public_access  = var.endpoint_public_access #true
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  # timeouts {
  #   create = var.cluster_create_timeout
  #   delete = var.cluster_delete_timeout
  # }

  depends_on = [
    aws_cloudwatch_log_group.cloudwatch_log_grp,
    aws_iam_role_policy_attachment.cluster_attach,
    aws_iam_role_policy_attachment.po-cluster-AmazonEKSVPCResourceController
    ]
}

# Cluster auth
data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.cluster.name
}

provider "kubernetes" {
  host                   = "${aws_eks_cluster.cluster.endpoint}"
  cluster_ca_certificate = "${base64decode(aws_eks_cluster.cluster.certificate_authority.0.data)}"
  token                  = "${data.aws_eks_cluster_auth.cluster_auth.token}"
  # load_config_file       = false
}

# resource "kubernetes_config_map_v1_data" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }
#   data = {
#     mapRoles = data.template_file.aws_auth_cm_windows.rendered
#     mapUsers = yamlencode(var.map_users)
#   }
#   force = true

#   depends_on = [
#     aws_eks_cluster.cluster
#   ]
# }
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = data.template_file.aws_auth_cm_windows.rendered
    mapUsers = yamlencode(var.map_users)
  }
  # force = true

  depends_on = [
    aws_eks_cluster.cluster
  ]
}

resource "kubernetes_config_map" "amazon_vpc_cni" {
  metadata {
    name      = "amazon-vpc-cni"
    namespace = "kube-system"
  }
  data = {
    enable-windows-ipam = "true"
  }

  depends_on = [
    aws_eks_cluster.cluster
  ]
}