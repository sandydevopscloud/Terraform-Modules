resource "aws_instance" "Public-Servers" {
  #   count                       = length(var.public_cidr_block)
  count                       = var.environment == "PRD" ? 3 : 3 # Create 3 public if true, else 1 public instance.
  ami                         = lookup(var.amis, var.region_name)
  instance_type               = var.ec2_inst_type #"t3.micro"
  key_name                    = var.key_name      #"sandy-pem"
  subnet_id                   = element(var.public_subnet, count.index + 1)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = "true"
  iam_instance_profile        = var.iam_instance_profile

  tags = {
    Name        = "Public-SRV-${count.index}"
    environment = var.environment
    # Owner       = "Sandy"
    # Costcenter  = ""
  }
  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install nginx -y
        echo "<h1> ${var.vpc_name}-Public-Server-${count.index} </h1>" >> /var/www/html/index.html
        sudo systemctl start nginx
        sudo systemctl enable nginx
    EOF

  depends_on = [var.elb_listener_public]
}

resource "aws_instance" "Private-Servers" {
  # count                  = length(var.private_cidr_block)
  count                  = var.environment == "PRD" ? 3 : 3 # Create 1 private if true, else 2 private instance.
  ami                    = lookup(var.amis, var.region_name)
  instance_type          = var.ec2_inst_type #"t3.micro"
  key_name               = var.key_name      #"sandy-pem"
  subnet_id              = element(var.private_subnet, count.index)
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name        = "Private-SRV-${count.index}"
    environment = var.environment
    # Owner       = "Sandy"
    # Costcenter  = ""
  }
  depends_on = [var.elb_listener]
}
