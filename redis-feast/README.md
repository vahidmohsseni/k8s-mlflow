## Redis for FEAST online store

### Installation
Run the script inside the `build.sh` file. 

```shell
chmod +x build.sh
./build.sh
```

### Details
The above command will run a redis server inside a Kubernetes Cluster. The address and port will be printed at the end. 

The redis server version is 7.0
The default memory size is 1GB
The namespace for the redis is `redis-feast`
