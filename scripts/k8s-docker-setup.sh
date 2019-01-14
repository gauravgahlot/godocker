#!/bin/bash

#  +---------------------------------+
#  +	INSTALL DOCKER CE 18.03.0    +
#  +---------------------------------+

# install dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# add repositry for Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

# list all stable versions
apt-cache madison docker-ce

# install docker 18.03
sudo apt-get install -y docker-ce=18.03.0~ce-0~ubuntu



#  +--------------------------------- ---+
#  +	INSTALL KUBERNETES COMPONENTS    +		
#  +-------------------------------------+

# add repository for K8s components
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

# pull in the updates for repositories
sudo apt-get update

# install K8s components
sudo apt-get install -y kubeadm kubectl kubelet kubernetes-cni

kubectl apply --filename https://git.io/weave-kube-1.6