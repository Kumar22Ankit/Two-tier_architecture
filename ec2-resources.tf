# Public subnet EC2 instance1
resource "aws_instance" "two_tier_web_server_1" {
  ami             = "ami-0aebec83a182ea7ea"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two_tier_ec2_sg.id]
  subnet_id       = aws_subnet.two_tier_pub_sub_1.id
  
  tags = {
    Name = "two_tier_web_server_1"
  }

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

# Public subnet  EC2 instance 2
resource "aws_instance" "two_tier_web_server_2" {
  ami             = "ami-0aebec83a182ea7ea"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.two_tier_ec2_sg.id]
  subnet_id       = aws_subnet.two_tier_pub_sub_2.id
  
  tags = {
    Name = "two_tier_web_server_2"
  }

  user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y 
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
}

#EIP

resource "aws_eip" "two_tier_web_server_1_eip" {
  vpc = true

  instance                  = aws_instance.two_tier_web_server_1.id
  depends_on                = [aws_internet_gateway.two_tier_igw]
}

resource "aws_eip" "two_tier_web_server_2_eip" {
  vpc = true

  instance                  = aws_instance.two_tier_web_server_2.id
  depends_on                = [aws_internet_gateway.two_tier_igw]
}

