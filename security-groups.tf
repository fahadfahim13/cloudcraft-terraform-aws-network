resource "aws_security_group" "alb-security-group" {
  name        = "alb-security-group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "Application Load Balancer Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4-1" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4-2" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-1" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-1" {
  security_group_id = aws_security_group.alb-security-group.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# New Security Group for the Web Server

resource "aws_security_group" "web-server-security-group" {
  name_prefix = "web-server-security-group"
  description = "Allow SSH access and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "Web Server Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4-3" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4-4" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4-5" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6-2" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-2" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6-2" {
  security_group_id = aws_security_group.web-server-security-group.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_security_group" "db-security-group" {
  name_prefix = "db-security-group"
  description = "Allow MySQL access and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "DB Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_ipv4-1" {
  security_group_id = aws_security_group.db-security-group.id
  referenced_security_group_id = aws_security_group.web-server-security-group.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4-3" {
  security_group_id = aws_security_group.db-security-group.id
  referenced_security_group_id = aws_security_group.web-server-security-group.id
  ip_protocol       = "-1" # semantically equivalent to all ports
}


