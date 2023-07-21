resource "aws_security_group" "web_server-sg" {
    name = "web-server-sg"
    description = "web server security group"
}

resource "aws_security_group_rule" "web_server-sg-rule" {
    security_group_id = aws_security_group.web_server-sg.id
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "web_server-sg-rule01" {
    security_group_id = aws_security_group.web_server-sg.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "web_server-sg-rule02" {
    security_group_id = aws_security_group.web_server-sg.id
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
}