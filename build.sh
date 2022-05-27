#!/bin/sh

sed -i 's/MLFLOW_DOCKER_IMAGE/vahidm\/mlflow/g' deploy/kubernetes/mlflow-deployment.yaml

kubectl apply -f deploy/kubernetes/mlflow-namespace.yaml
kubectl apply -f deploy/kubernetes/mlflow-deployment.yaml
kubectl apply -f deploy/kubernetes/mlflow-service.yaml


export MLFLOW_IP=$(kubectl -n mlflow-k8s get service mlflow -o jsonpath='{.spec.clusterIP}')

echo MLFLOW node port ip address: $MLFLOW_IP 