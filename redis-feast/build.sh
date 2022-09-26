#!/bin/sh

kubectl apply -f deploy/kubernetes/redis-namespace.yaml
kubectl apply -f deploy/kubernetes/redis-config.yaml
kubectl apply -f deploy/kubernetes/redis-deployment.yaml
kubectl apply -f deploy/kubernetes/redis-service.yaml

kubectl get deployments.apps -n redis-feast -o jsonpath='{.status.conditions}' | echo "Waiting for the deployment to be available ..."
kubectl wait deployment -n redis-feast redis --for condition=Available=True

export REDIS_IP=$(kubectl -n redis-feast get service redis -o jsonpath='{.spec.clusterIP}')
export REDIS_PORT=$(kubectl -n redis-feast get service redis -o jsonpath='{.spec.ports[].port}')

echo Redis service is running on: $REDIS_IP:$REDIS_PORT
