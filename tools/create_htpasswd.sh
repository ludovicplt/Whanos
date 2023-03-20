#!/bin/sh

mkdir -p /opt/registry/creds
htpasswd -Bbn $1 "$2" > /opt/registry/creds/htpasswd