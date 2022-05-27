#!/bin/sh

sed -i 's/MLFLOW_DOCKER_IMAGE/vahidm\/mlflow/g' deploy/kubernetes/mlflow-deployment.yaml

kubectl apply -f deploy/kubernetes/mlflow-namespace.yaml
kubectl apply -f deploy/kubernetes/mlflow-deployment.yaml
kubectl apply -f deploy/kubernetes/mlflow-service.yaml

kubectl get deployments.apps -n mlflow-k8s mlflow -o jsonpath='{.status.conditions}' | echo "Waiting fot the deployment to be available ..."
kubectl wait deployment -n mlflow-k8s mlflow --for condition=Available=True

export MLFLOW_IP=$(kubectl -n mlflow-k8s get service mlflow -o jsonpath='{.spec.clusterIP}')
export MLFLOW_PORT=$(kubectl -n mlflow-k8s get service mlflow -o jsonpath='{.spec.ports[].port}')

echo MLFlow service is running on: $MLFLOW_IP:$MLFLOW_PORT
