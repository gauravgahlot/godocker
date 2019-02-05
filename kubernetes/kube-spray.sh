#!/bin/bash

# install ansible
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# install python dependencies
sudo apt install -y python3-pip
pip3 install --upgrade pip
pip install jinja2
sudo apt-get install -y python-netaddr

# enable IPv4 forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# disable firewall
sudo ufw disable

# install git
sudo apt-get install -y git

# clone the kubespray repository
git clone https://github.com/kubernetes-incubator/kubespray.git

# copy inventory  from `sample` to `mycluster`
cd kubespray/
cp -rfp inventory/sample inventory/mycluster
