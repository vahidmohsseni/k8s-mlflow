## A Release of MLflow in Docker for Kubernetes

## Manual
To deploy the MLFlow in the Kubernetes cluster you need to, first, build the Docker image and push it to a registery accessible by your cluster.

### Docker
You can fetch it directly from docker hub:
```shell
docker pull vahidm/mlflow
docker run vahidm/mlflow
```
Alternatively, you can build the image and customize the environment variables in `deploy/docker/Dockerfile`.

```shell
git clone https://github.com/vahidmohsseni/k8s-mlflow
cd k8s-mlflow/deploy/docker

docker build -t mlflow .
docker run -p 8001:8001 mlflow
```

### Kubernetes
To run the mlflow in kubernetes you can use the `yaml` files located in `deploy/kubernetes/` directory. 
You only need to change the `MLFLOW_DOCKER_IMAGE` to point your local image or to `vahidm/mlflow` alternatively.

```shell
git clone https://github.com/vahidmohsseni/k8s-mlflow

cd k8s-mlflow/deploy/kubernetes
sed -i 's/MLFLOW_DOCKER_IMAGE/vahidm\/mlflow/g' mlflow-deployment.yaml

kubectl apply -f mlflow-namespace.yaml
kubectl apply -f mlflow-deployment.yaml
kubectl apply -f mlflow-service.yaml
```

To test if is working:

```shell
export MLFLOW_IP=$(kubectl -n mlflow-k8s get service mlflow -o jsonpath='{.spec.clusterIP}')
curl $MLFLOW_IP:8001
```

## Auto Deploy
Run the `build.sh` to deploy the application on the kubernetes. 

```shell
chmod +x build.sh
./build.sh
```
The output will look like as following:
```shell
namespace/mlflow-k8s created
deployment.apps/mlflow created
service/mlflow created
Waiting fot the deployment to be available ...
deployment.apps/mlflow condition met
MLFlow service is running on: 10.100.79.201:8001
```
