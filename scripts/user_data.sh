#!/bin/bash

sudo su

yum update -y
yum install -y docker

service docker start
usermod -a -G docker ec2-user

docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always portainer/portainer-ce:latest