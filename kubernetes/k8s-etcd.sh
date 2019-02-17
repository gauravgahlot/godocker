#!/bin/bash

# disable swap
swapoff -a
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab


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


# configure the kubelet to be a service manager for etcd
cat << EOF > /etc/systemd/system/kubelet.service.d/20-etcd-service-manager.conf
[Service]
ExecStart=
ExecStart=/usr/bin/kubelet --address=127.0.0.1 --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true
Restart=always
EOF


# restart kubelet
systemctl daemon-reload
systemctl restart kubelet
