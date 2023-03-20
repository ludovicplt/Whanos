#!/bin/bash

if [ -f Dockerfile ]; then
    echo "docker"
    exit 0
fi

if [ -f Makefile ]; then
    echo "c"
    exit 0
fi

if [ -f pom.xml ]; then
    echo "java"
    exit 0
fi

if [ -f package.json ]; then
    echo "javascript"
    exit 0
fi

if [ -f requirements.txt ]; then
    echo "python"
    exit 0
fi

if [ -f app/main.bf ]; then
    echo "befunge"
    exit 0
fi

echo "Unknown language" >&2
exit 1