#!/bin/bash

# Create cluster with specific port mapping
CLUSTER_NAME='nginx-web'
k3d cluster create $CLUSTER_NAME --api-port 6550 -p "9090:80@loadbalancer" --agents 1
export KUBECONFIG="$(k3d kubeconfig write k3s-default)"

# Create deployment, service, and ingress
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
