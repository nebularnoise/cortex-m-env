#!/bin/bash

set -e

DOCKER_USERNAME="nebularnoise"
IMAGE_NAME="cortex-m-env"

TAGS=$(cat TAGS)

# Build the Docker image with each tag
for TAG in $TAGS; do
  echo "Building image with tag: $TAG"
  docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$TAG .
done

# Push the image to DockerHub with each tag
for TAG in $TAGS; do
  echo "Pushing image with tag: $TAG"
  docker push $DOCKER_USERNAME/$IMAGE_NAME:$TAG
done

echo "Build and push completed successfully!"