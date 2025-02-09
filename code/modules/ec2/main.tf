resource "aws_instance" "public" {
  count                  = length(var.public_subnet_ids)
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.public_sg_id]
  key_name               = var.key_name
  user_data              = <<-EOF
                            #!/bin/bash
                            sudo apt update -y
                            sudo apt install -y nginx
                            sudo systemctl restart nginx
                          EOF

  tags = {
    Name = "public-ec2-${count.index + 1}"
  }
}

# Private EC2 Instances (Web Server)
resource "aws_instance" "private" {
  count                  = length(var.private_subnet_ids)
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [var.private_sg_id]
  key_name               = var.key_name
  user_data              = <<-EOF
                            #!/bin/bash
                            sudo apt-get update -y
                            sudo apt-get install -y apache2
                            sudo systemctl restart apache2
                          EOF

  tags = {
    Name = "private-ec2-${count.index + 1}"
  }

  depends_on = [var.nat_gateway_id]
}
