resource "aws_security_group" "web_server-sg" {
  name        = "web-server-sg"
  description = "web server security group"

  tags = {
    "Name" = "web-server-sg"
  }
}

resource "aws_security_group_rule" "web_server-sg-rule" {
  security_group_id = aws_security_group.web_server-sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_server-sg-rule01" {
  security_group_id = aws_security_group.web_server-sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_server-sg-rule02" {
  security_group_id = aws_security_group.web_server-sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_server-sg-rule03" {
  security_group_id = aws_security_group.web_server-sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}