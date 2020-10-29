#!/bin/bash
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


sudo swapoff -a

kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


#kubectl apply -f https://docs.projectcalico.org/v3.11/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.11/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

#curl https://docs.projectcalico.org/v3.11/manifests/calico.yaml -O
#POD_CIDR="192.168.0.0/16" \
#sed -i -e "s?192.168.0.0/16?$POD_CIDR?g" calico.yaml
#kubectl apply -f calico.yaml

#Ref https://docs.projectcalico.org/getting-started/kubernetes/quickstart

kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml

#for cluster auto start after reboot
git clone https://github.com/xetys/k8s-self-hosted-recovery
cd k8s-self-hosted-recovery
./install.sh
