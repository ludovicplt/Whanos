#!/bin/bash
DOCKER_REGISTRY_HOST=$(cat /var/lib/jenkins/registry_host.txt)

docker tag $1 $DOCKER_REGISTRY_HOST/$1
docker push $DOCKER_REGISTRY_HOST/$1