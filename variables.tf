variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "ecs-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN Gateway"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

# ECS Cluster Variables
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "ecs-integrated"
}

variable "fargate_weight" {
  description = "Weight for FARGATE capacity provider"
  type        = number
  default     = 50
}

variable "fargate_base" {
  description = "Base count for FARGATE capacity provider"
  type        = number
  default     = 20
}

variable "fargate_spot_weight" {
  description = "Weight for FARGATE_SPOT capacity provider"
  type        = number
  default     = 50
}

# ECS Service Variables
variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "ecs-standalone"
}

variable "assign_public_ip" {
  description = "Assign public IP to ECS tasks"
  type        = bool
  default     = true
}

# Container Configuration Variables
variable "cpu_architecture" {
  description = "CPU architecture for ECS tasks"
  type        = string
  default     = "X86_64"
}

variable "operating_system_family" {
  description = "Operating system family for ECS tasks"
  type        = string
  default     = "LINUX"
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
  default     = "kodekloud/ecommerce:apparels"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 8080
}

variable "host_port" {
  description = "Host port mapping"
  type        = number
  default     = 8080
}

variable "container_protocol" {
  description = "Protocol for port mapping"
  type        = string
  default     = "tcp"
}

variable "volume_name" {
  description = "Name of the ECS volume"
  type        = string
  default     = "ex-vol"
}

variable "container_mount_path" {
  description = "Container path for volume mount"
  type        = string
  default     = "/var/www/ex-vol"
}

# Security Group Variables
variable "ingress_from_port" {
  description = "Starting port for security group ingress rule"
  type        = number
  default     = 8080
}

variable "ingress_to_port" {
  description = "Ending port for security group ingress rule"
  type        = number
  default     = 8080
}

variable "ingress_protocol" {
  description = "Protocol for security group ingress rule"
  type        = string
  default     = "tcp"
}

variable "ingress_cidr" {
  description = "CIDR block for security group ingress rule"
  type        = string
  default     = "0.0.0.0/0"
}

variable "egress_protocol" {
  description = "Protocol for security group egress rule"
  type        = string
  default     = "-1"
}

variable "egress_cidr" {
  description = "CIDR block for security group egress rule"
  type        = string
  default     = "0.0.0.0/0"
}
