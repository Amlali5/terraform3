variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_lb_sg_id" {
  description = "Security group ID for the public load balancer"
  type        = string
}

variable "private_lb_sg_id" {
  description = "Security group ID for the private load balancer"
  type        = string
}
variable "public_ec2" {
  description = "EC2 instance for target group attachment"
  type        = list(string)
}
variable "private_ec2" {
  description = "EC2 instance for target group attachment"
  type        = list(string)
}
