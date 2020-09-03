#!/bin/sh
sudo swapoff -a
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
   
sudo apt-get install -y docker.io


sleep 60
sudo cp daemon.json /etc/docker 

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
      
sudo apt update -y
   
sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold docker.io kubelet kubeadm kubectl
sleep 60
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service


sudo kubeadm init --pod-network-cidr=192.168.0.0/16

sleep 60     

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sleep 60 

kubectl apply -f rbac-kdd.yaml
kubectl apply -f calico.yaml