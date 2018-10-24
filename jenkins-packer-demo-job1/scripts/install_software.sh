#!/bin/bash
echo 'update system and install packages'
yum clean all
rm -rf /var/cache/yum/*
yum -y update
# install epel for nginx
yum install -y epel-release
yum install -y nginx vim lvm2 yum-utils device-mapper-persistent-data
# add the docker repo to yum
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# install the latest docker
yum install -y docker-ce
# start docker and enable the service to survive an reboot
systemctl start docker
systemctl enable docker
# check if it worked
echo 'print docker version info, to verify docker is installed correctly'
docker version

# now the real stuff.
echo 'put nginx config in /etc/nginx/nginx.conf'
echo 'user www-data;
worker_processes auto;
pid /run/nginx.pid;
events {
        worker_connections 768;
        # multi_accept on;
}
http {
  server {
    listen 80;
    location / {
      proxy_pass http://localhost:5000/;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}' > /etc/nginx/nginx.conf


# The docker demo app
# This service idea is from: https://container-solutions.com/running-docker-containers-with-systemd/
docker pull training/webapp

echo 'create service to let the docker app run'
echo '[Unit]
Description=Dumb demo hello world demo app
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
RestartSec=10s
ExecStartPre=-/usr/bin/docker stop demo
ExecStartPre=-/usr/bin/docker rm demo
#ExecStartPre=/usr/bin/docker pull training/webapp
ExecStart=/usr/bin/docker run -p 5000:5000 --rm --name demo training/webapp

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/docker.demo.service

systemctl enable docker.demo.service
systemctl start docker.demo.service

# for now disable the firewall, for real I should add the correct rules. 
systemctl disable firewalld
systemctl stop firewalld

sleep 5
echo 'check localhost:5000 to see if the app is running.....'
curl localhost:5000