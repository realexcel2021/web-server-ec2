sudo mkfs.xfs /dev/xvdb
sudo mount /dev/xvdb /var/www/html

sudo yum update -y

sudo yum install httpd -y

sudo yum install git -y

git clone https://bitbucket.org/dptrealtime/html-web-app/src/master/

cd master

sudo systemctl enable httpd.service
sudo systemctl start httpd.service

sudo cp -r /home/ec2-user/master /var/www/html
