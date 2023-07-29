#!/bin/bash

sudo yum update -y

sudo yum install httpd -y

sudo yum install git -y

git clone https://bitbucket.org/dptrealtime/html-web-app/src/master/

cd master

sudo systemctl enable httpd.service
sudo systemctl start httpd.service

sudo mkfs.xfs /dev/xvdb
sudo mount /dev/xvdb /var/www/html
