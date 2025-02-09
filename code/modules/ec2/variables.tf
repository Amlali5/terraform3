variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "public_sg_id" {
  description = "Security group ID for public EC2 instances"
  type        = string
}

variable "private_sg_id" {
  description = "Security group ID for private EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "internal_lb_dns" {
  description = "DNS name of the internal load balancer"
  type        = string
}
variable "nat_gateway_id" {
  description = "ID of the NAT gateway"
  type        = string
 
}