#!/bin/bash
minikube start --driver=docker
eval $(minikube -p minikube docker-env)
docker build -t nginx nginx
kubectl apply -f nginx/nginx-deployment.yaml
