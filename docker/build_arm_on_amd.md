# Building and Running ARM Docker Images on AMD Machines

This document describes how to build and run ARM Docker images on AMD machines using Docker's `buildx` feature.

## Prerequisites

- Docker 19.03 or later
- Docker buildx (included in Docker 19.03 and later)

## Steps

1. **Create a new builder instance that supports the ARM platform**

Docker buildx allows you to create a new builder instance that can build images for multiple platforms. To create a new builder instance that supports the ARM platform, run the following commands:

```bash
docker buildx create --name mybuilder --driver docker-container --platform linux/amd64,linux/arm64 --use
docker buildx inspect mybuilder --bootstrap 
```

The docker buildx inspect --bootstrap command should show linux/arm64 in the "Platforms" section.

You can now use Docker buildx to build your Docker image for the ARM platform. Here's an example Dockerfile:

```Dockerfile
FROM --platform=linux/arm64 arm64v8/ros:humble-perception 

...

```

Check if QEMU is installed: Run ```docker run --rm --privileged multiarch/qemu-user-static --reset -p yes``` to install QEMU and register static binaries in the kernel.

To build this Dockerfile for the ARM platform, run the following command:

```docker buildx build --platform linux/arm64 -t your-image-name .```

Replace your-image-name with the name you want to give to your Docker image.

You can run the ARM Docker image on your AMD machine using Docker's QEMU support. To run the image, use the docker run command

```docker run --platform linux/arm64 -it your-image-name```