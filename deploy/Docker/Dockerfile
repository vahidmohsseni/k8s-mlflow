FROM python:3.8-slim-buster

WORKDIR /mlflow
ARG MLFLOW_VERSION=1.19.0
RUN pip install --no-cache-dir mlflow==$MLFLOW_VERSION

ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts

EXPOSE 8001
CMD mlflow server                                    \
            --backend-store-uri ${BACKEND_URI}       \
            --default-artifact-root ${ARTIFACT_ROOT} \
            --host 0.0.0.0 --port 8001 
