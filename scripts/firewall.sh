#!/bin/bash


# remove lock from dpkg and apt/lists
rm /var/lib/dpkg/lock
rm /var/lib/apt/lists/lock
apt-get update


# install firewalld
apt install -y --allow-unauthenticated firewalld


# set firewalld policy
firewall-cmd --zone=public --add-port=16443/tcp --permanent
firewall-cmd --zone=public --add-port=6443/tcp --permanent
firewall-cmd --zone=public --add-port=4001/tcp --permanent
firewall-cmd --zone=public --add-port=2379-2380/tcp --permanent
firewall-cmd --zone=public --add-port=10250/tcp --permanent
firewall-cmd --zone=public --add-port=10251/tcp --permanent
firewall-cmd --zone=public --add-port=10252/tcp --permanent
firewall-cmd --zone=public --add-port=30000-32767/tcp --permanent


# reload firewalld
firewall-cmd --reload


# list the policies
firewall-cmd --list-all --zone=public
