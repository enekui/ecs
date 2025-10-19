# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

# ECS Cluster Module
module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = var.ecs_cluster_name

  cluster_configuration = {}

  # Cluster capacity providers
  default_capacity_provider_strategy = {
    FARGATE = {
      weight = var.fargate_weight
      base   = var.fargate_base
    }
    FARGATE_SPOT = {
      weight = var.fargate_spot_weight
    }
  }

  tags = var.tags
}

# ECS Service Module
module "ecs_task_definition" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  # Service
  name           = var.ecs_service_name
  cluster_arn    = module.ecs.cluster_arn
  create_service = true

  assign_public_ip = var.assign_public_ip

  # Task Definition
  volume = {
    (var.volume_name) = {}
  }

  runtime_platform = {
    cpu_architecture        = var.cpu_architecture
    operating_system_family = var.operating_system_family
  }

  # Container definition(s)
  container_definitions = {
    al2023 = {
      image = var.container_image
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = var.container_protocol
        }
      ]

      mountPoints = [
        {
          sourceVolume  = var.volume_name,
          containerPath = var.container_mount_path
        }
      ]
    }
  }

  subnet_ids = module.vpc.public_subnets

  security_group_ingress_rules = {
    web = {
      from_port   = var.ingress_from_port
      to_port     = var.ingress_to_port
      ip_protocol = var.ingress_protocol
      cidr_ipv4   = var.ingress_cidr
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = var.egress_protocol
      cidr_ipv4   = var.egress_cidr
    }
  }

  tags = var.tags
}