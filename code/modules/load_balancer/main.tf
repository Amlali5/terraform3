# Public Load Balancer
resource "aws_lb" "public" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_lb_sg_id]
  subnets            = var.public_subnet_ids
  tags = {
    Name = "public-lb"
  }
}

# Private Load Balancer
resource "aws_lb" "private" {
  name               = "private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_lb_sg_id]
  subnets            = var.private_subnet_ids
  tags = {
    Name = "private-lb"
  }
}

# Public Target Group
resource "aws_lb_target_group" "public" {
  name     = "public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Private Target Group
resource "aws_lb_target_group" "private" {
  name     = "private-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Public Listener
resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public.arn
  }
}

# Private Listener
resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private.arn
  }
}

# Public Target Group Attachment
resource "aws_lb_target_group_attachment" "public" {
  for_each          = { for idx, id in var.public_ec2 : idx => id }
  target_group_arn  = aws_lb_target_group.public.arn
  target_id         = each.value
  port              = 80
}

# Private Target Group Attachment 
resource "aws_lb_target_group_attachment" "private" {
  for_each          = { for idx, id in var.private_ec2 : idx => id }
  target_group_arn  = aws_lb_target_group.private.arn
  target_id         = each.value
  port              = 80
}
