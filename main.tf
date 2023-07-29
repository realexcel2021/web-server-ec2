provider "aws" {
  region = var.region
}

resource "aws_key_pair" "web_server_key_pair" {
  key_name   = "web_Server"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "key-pair.pem"
}

resource "aws_eip" "web_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "web_eip_ass" {
  instance_id   = aws_instance.web_server.id
  allocation_id = aws_eip.web_eip.id
}

resource "aws_instance" "web_server" {
  ami           = "ami-0b026d11830afcbac"
  key_name      = aws_key_pair.web_server_key_pair.key_name
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.web_server-sg.name ]

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 5
  }

  tags = {
    Name = "Web-Server-Machine"
  }

  volume_tags = {
    Name = "Web-server-Storage"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = tls_private_key.rsa.private_key_pem
    timeout     = "4m"
  }

  provisioner "file" {
    source      = "./script.sh"
    destination = "/home/ec2-user/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/script.sh",
      "sudo /home/ec2-user/script.sh",
      "sudo cp -a /home/ec2-user/master/. /var/www/html"
    ]
  }

  depends_on = [
    aws_key_pair.web_server_key_pair,
    local_file.tf-key
  ]

}