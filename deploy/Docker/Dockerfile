FROM python:3.8-slim-buster

WORKDIR /mlflow
ARG MLFLOW_VERSION=1.19.0
RUN pip install --upgrade pip
RUN pip install --no-cache-dir mlflow==$MLFLOW_VERSION

ENV BACKEND_URI sqlite:////mlflow/mlflow.db
ENV ARTIFACT_ROOT /mlflow/artifacts
ENV BACK_END_PORT 8001
ENV NUMBER_OF_GC 4


CMD mlflow server                                    \
            --backend-store-uri ${BACKEND_URI}       \
            --default-artifact-root ${ARTIFACT_ROOT} \
            --workers ${NUMBER_OF_GC}                \
            --host 0.0.0.0                           \
            --port ${BACK_END_PORT}
