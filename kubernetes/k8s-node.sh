#!/bin/bash


# install dependencies
apt install -y apt-transport-https curl


# add repository for K8s components
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF


# pull in the updates for repositories
sudo apt-get update


# install K8s components
apt-get install -y docker.io kubeadm kubelet
apt-mark hold kubelet kubeadm 
