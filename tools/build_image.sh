#!/bin/bash
set -e

LANGUAGE=$(/opt/tools/find_language.sh)

echo "building image '$1' using strategy of language '$LANGUAGE'"

if [[ $LANGUAGE != "docker" ]]; then
    cp /opt/images/$LANGUAGE/Dockerfile.standalone Dockerfile
    docker build -t whanos-$LANGUAGE-standalone -t $1 .
else
    docker build -t $1 .
fi