#VPC Creation
resource "aws_vpc" "two_tier_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "two_tier_vpc"
  }
}

#Public Subnets Creation
resource "aws_subnet" "two_tier_pub_sub_1" {
  vpc_id = aws_vpc.two_tier_vpc.id
  cidr_block = "10.0.0.0/18"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
  Name = "two_tier_pub_sub_1"
  }
}


resource "aws_subnet" "two_tier_pub_sub_2" {
  vpc_id = aws_vpc.two_tier_vpc.id
  cidr_block = "10.0.64.0/18"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
  Name = "two_tier_pub_sub_2"
  }
}

#Private Subnets Creation
resource "aws_subnet" "two_tier_pvt_sub_1" {
  vpc_id = aws_vpc.two_tier_vpc.id
  cidr_block = "10.0.128.0/18"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
  Name = "two_tier_pvt_sub_1"
  }
}

resource "aws_subnet" "two_tier_pvt_sub_2" {
  vpc_id = aws_vpc.two_tier_vpc.id
  cidr_block = "10.0.192.0/18"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
  Name = "two_tier_pvt_sub_2"
  }
}

#Internet Gateway Creation
resource "aws_internet_gateway" "two_tier_igw" {
  tags = {
    Name = "two_tier_igw"
  }
  vpc_id = aws_vpc.two_tier_vpc.id
}

#Route Table Creation
resource "aws_route_table" "two_tier_rt" {
  tags = {
    Name = "two_tier_rt"
  }
  vpc_id = aws_vpc.two_tier_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.two_tier_igw.id
  }
}

#Route Table Assosiation
resource "aws_route_table_association" "two_tier_rt_as_1" {
  subnet_id = aws_subnet.two_tier_pub_sub_1.id
  route_table_id = aws_route_table.two_tier_rt.id
}

resource "aws_route_table_association" "two_tier_rt_as_2" {
  subnet_id = aws_subnet.two_tier_pub_sub_2.id
  route_table_id = aws_route_table.two_tier_rt.id
}

#Load Balancer Creation
resource "aws_lb" "two_tier_lb" {
  name = "two-tier-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.two_tier_alb_sg.id]
  subnets = [aws_subnet.two_tier_pub_sub_1.id, aws_subnet.two_tier_pub_sub_2.id]

  tags = {
  Enviroment = "two_tier_lb"
  }
}

resource "aws_lb_target_group" "two_tier_lb_tg" {
  name = "two-tier-lb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.two_tier_vpc.id
}

#Load Balancer Listener Creation
resource "aws_alb_listener" "two_tier_lb_listner" {
  load_balancer_arn = aws_lb.two_tier_lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.two_tier_lb_tg.arn
  }
}

#Create Target Group
resource "aws_lb_target_group" "two_tier_loadb_target" {
  name = "target"
  depends_on = [aws_vpc.two_tier_vpc]
  port = "80"
  protocol = "HTTP"
  vpc_id = aws_vpc.two_tier_vpc.id

}

resource "aws_lb_target_group_attachment" "two_tier_tg_attch_1" {
  target_group_arn = aws_lb_target_group.two_tier_loadb_target.arn
  target_id        = aws_instance.two_tier_web_server_1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "two_tier_tg_attch_2" {
  target_group_arn = aws_lb_target_group.two_tier_loadb_target.arn
  target_id        = aws_instance.two_tier_web_server_2.id
  port             = 80
}

# Create Subnet group database
resource "aws_db_subnet_group" "two_tier_db_sub" {
  name       = "two_tier_db_sub"
  subnet_ids = [aws_subnet.two_tier_pvt_sub_1.id, aws_subnet.two_tier_pvt_sub_2.id]
}
