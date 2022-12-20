resource "aws_iam_role" "linux_role" {
  name = "eks_linux_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "po-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.linux_role.name
}

resource "aws_iam_role_policy_attachment" "po-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.linux_role.name
}

resource "aws_iam_role_policy_attachment" "po-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.linux_role.name
}


resource "aws_eks_node_group" "linux_ng" {
  cluster_name         = var.cluster_name
  node_group_name      = var.linux_node_group_name
  node_role_arn        = aws_iam_role.linux_role.arn
  subnet_ids           = var.pvt_subnet_id
  ami_type             = var.ami_type
  capacity_type        = var.capacity_type
  disk_size            = var.disk_size
  force_update_version = var.force_update_version
  instance_types       = var.instance_types
  version              = var.kubernetes_version
  release_version      = var.release_version

  remote_access {
    ec2_ssh_key = aws_key_pair.node-key.key_name #var.ec2_ssh_key
    source_security_group_ids = var.source_security_group_ids
  }
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  # tags{
  #   resource_type = "instance"
  #   tags          = { "kubernetes.io/cluster/${var.cluster_name}" = "owned", "kubernetes.io/os" = "linux" }
  # }

  depends_on = [
    aws_eks_cluster.cluster,
    aws_iam_role_policy_attachment.po-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.po-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.po-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# resource "null_resource" "install_vpc_controller" {
#   provisioner "local-exec" {
#     command = "eksctl utils install-vpc-controllers --cluster ${var.cluster_name} --approve"
#   }
#   depends_on = [
#     aws_eks_node_group.linux_ng
#   ]
# }