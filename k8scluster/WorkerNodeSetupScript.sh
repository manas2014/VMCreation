#!/bin/sh
sudo swapoff -a
sudo apt-get update -y
sudo apt-get upgrade -y  
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

#sudo kubeadm join 172.16.94.10:6443 --token 9woi9e.gmuuxnbzd8anltdg --discovery-token-ca-cert-hash sha256:f9cb1e56fecaf9989b5e882f54bb4a27d56e1e92ef9d56ef19a6634b507d76a9

kubeadm join 10.0.1.6:6443 --token i83dvj.5mnajooti6uioq6l --discovery-token-ca-cert-hash sha256:0b6f8b0d324c1377a605bd768e8489df72eb77ece0397fcab79cd6d576d8c1bf 