#!/bin/bash
minikube start --driver=docker
eval $(minikube -p minikube docker-env)

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f metallb-configmap.yaml
kubectl apply -f mini-secret.yaml

docker build -t nginx nginx
kubectl apply -f nginx/nginx-deployment.yaml
kubectl apply -f nginx/nginx-service.yaml

kubectl apply -f mariadb/mariadb-statefulset.yaml
kubectl apply -f mariadb/mariadb-service.yaml

kubectl apply -f phpmyadmin/phpmyadmin-deployment.yaml
kubectl apply -f phpmyadmin/phpmyadmin-service.yaml
