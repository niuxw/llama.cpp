ARG UBUNTU_VERSION=22.04

# This needs to generally match the container host's environment.
ARG CUDA_VERSION=11.7.1

# Target the CUDA build image
ARG BASE_CUDA_DEV_CONTAINER=nvidia/cuda:${CUDA_VERSION}-devel-ubuntu${UBUNTU_VERSION}

FROM ${BASE_CUDA_DEV_CONTAINER} as build

# Unless otherwise specified, we make a fat build.
ARG CUDA_DOCKER_ARCH=all

RUN apt-get update && \
    apt-get install -y build-essential python3 python3-pip

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

WORKDIR /app

COPY . .

# Set nvcc architecture
ENV CUDA_DOCKER_ARCH=${CUDA_DOCKER_ARCH}
# Enable cuBLAS
ENV LLAMA_CUBLAS=1

RUN make

ENTRYPOINT ["/app/.devops/tools.sh"]
