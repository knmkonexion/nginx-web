#!/bin/bash

# Create cluster with specific port mapping
k3d cluster create --api-port 6550 -p "9090:80@loadbalancer" --agents 2

export KUBECONFIG="$(k3d kubeconfig write k3s-default)"

kubectl create deployment nginx --image=knmkonexion/nginx-site:latest
kubectl create service clusterip nginx --tcp=80:80
kubectl apply -f k8s/ingress.yaml.
