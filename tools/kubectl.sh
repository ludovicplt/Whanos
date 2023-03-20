#!/bin/bash

if [[ -f /var/jenkins_home/kubeconfig.yml ]]; then
    kubectl --kubeconfig=/var/jenkins_home/kubeconfig.yml $@
else
    (cd /opt/jenkins && docker-compose run --rm jenkins /opt/tools/kubectl.sh $@)
fi