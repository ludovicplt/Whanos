#!/bin/bash
set -e

mkdir -p "/tmp/base_images/$1"
cp -f "/opt/images/$1/Dockerfile.base" "/tmp/base_images/$1/Dockerfile"
docker build -t "whanos-$1" "/tmp/base_images/$1"
rm -R "/tmp/base_images/$1"