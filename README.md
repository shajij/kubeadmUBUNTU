# DockerOnUbuntu
Installs the latest version of Docker community on Ubuntu 18.04

# kubeadmUBUNTU
Setting up and Installing a Kubernetes Cluster with Kubeadm

Note: 

1. Needs to be run with Sudo
2. Calico is used for pod networking
3. if you need the master node to take pods then run this
kubectl taint nodes --all node-role.kubernetes.io/master-
