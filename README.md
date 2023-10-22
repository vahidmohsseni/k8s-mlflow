## A Release of MLflow Tracking Server in Docker for Kubernetes

## Redis
Redis is required component for the FEAST online store. 
Open the `redis-feast` directory for more information and instruction. 

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

##  Acknowledgement
This project has received funding from the Key Digital Technologies Joint Undertaking (KDT JU) under grant agreement No 877056. The JU receives support from the European Union’s Horizon 2020 research and innovation programme and Spain, Italy, Austria, Germany, Finland, Switzerland.

![FRACTAL Logo](https://cloud.hipert.unimore.it/apps/files_sharing/publicpreview/jHmgbEb2QJoe8WY?x=1912&y=617&a=true&file=fractal_logo_2.png&scalingup=0)

![EU Logo](https://cloud.hipert.unimore.it/apps/files_sharing/publicpreview/pessWNfeqBfYi3o?x=1912&y=617&a=true&file=eu_logo.png&scalingup=0)
![KDT Logo](https://cloud.hipert.unimore.it/apps/files_sharing/publicpreview/yd7FgKisNgtLPTy?x=1912&y=617&a=true&file=kdt_logo.png&scalingup=0)  
