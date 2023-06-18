#! /bin/bash
sudo yum install -y docker
usermod -aG docker ec2-user
sudo systemctl enable docker
sudo systemctl start docker
docker run -d --name nginx -p 8181:80 nginx:alpine

cat << "HERE" > /etc/update-motd.d/30-banner
##Homework 20##
##Andrii Klimakhin##
HERE
update-motd --force