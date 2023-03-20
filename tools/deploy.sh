#!/bin/bash
set -e

DOCKER_REGISTRY_HOST=$(cat /var/lib/jenkins/registry_host.txt)

docker stop $1 || true && docker rm $1 || true

if [[ ! -f whanos.yml ]]; then
    echo "whanos.yml has not been found. No deployment to do."
    docker run --name $1 -d $1
    echo "Created or recreated container locally"
    exit 0
fi

/opt/tools/generate_k8s.py $1 $DOCKER_REGISTRY_HOST/$1 $PWD
/opt/tools/kubectl.sh apply -f deployment.yml -f service.yml
echo "Deployment done."