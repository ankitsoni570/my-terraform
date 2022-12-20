resource "aws_iam_role" "windows_role" {
  name = "eks_windows_iam_role"
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
resource "aws_iam_role_policy_attachment" "windows-attach1" {
  role       = aws_iam_role.windows_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "windows-attach2" {
  role       = aws_iam_role.windows_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "windows-attach3" {
  role       = aws_iam_role.windows_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "windows_profile" {
  name = "eks_windows_iam_profile"
  role = aws_iam_role.windows_role.name
}

data "aws_ssm_parameter" "eks_worker_windows" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2019-English-Full-EKS_Optimized-${var.kubernetes_version}/image_id"
}

data "template_file" "userdata_windows" {
  template = file("${path.module}/templates/userdata_windows.tpl")
  vars = {
    cluster_name = var.cluster_name
    kubelet_extra_args  = var.kubelet_extra_args
  }
}

resource "aws_security_group" "windows_sg" {
  name        = "windows_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "po-win-node-sg"
  }
}

resource "aws_launch_template" "workers" {
  name                   = var.lt_name
  vpc_security_group_ids = [aws_security_group.windows_sg.id,aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id]
  image_id               = data.aws_ssm_parameter.eks_worker_windows.value
  instance_type          = var.win_instance_type
  key_name               = aws_key_pair.node-key.key_name   # need to create dynamically
  user_data              = base64encode(data.template_file.userdata_windows.rendered)

  monitoring {
    enabled = false
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = var.volume_size
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags          = { "kubernetes.io/cluster/${var.cluster_name}" = "owned", "kubernetes.io/os" = "windows" }
  }

  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.windows_profile.arn
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }
  # depends_on = [
  #   null_resource.install_vpc_controller
  # ]
}

resource "aws_autoscaling_group" "workers" {

  name             = var.asg_name
  desired_capacity = var.win_desired_capacity
  max_size         = var.win_max_size
  min_size         = var.win_min_size

  launch_template {
    id      = aws_launch_template.workers.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.pvt_subnet_id
  health_check_type   = "EC2"

  lifecycle {
    create_before_destroy = true
    # ignore_changes        = [desired_capacity, target_group_arns]
  }
}