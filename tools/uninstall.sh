#!/bin/bash

cat /opt/jenkins/whanos.txt

(cd /opt/jenkins && docker-compose down)
rm -R /opt/jenkins
docker rmi $(docker images | grep "jenkins/jenkins" | cut -d" " -f1) 2>/dev/null
docker rmi $(docker images | grep "jenkins_jenkins" | cut -d" " -f1) 2>/dev/null

(cd /opt/registry && docker-compose down)
rm -R /opt/registry
docker rmi $(docker images | grep "registry" | cut -d" " -f1) 2>/dev/null

for image in $(ls /opt/images); do
    docker rmi $(docker images | grep "whanos-$image-standalone" | cut -d" " -f1) 2>/dev/null
    docker rmi $(docker images | grep "whanos-$image" | cut -d" " -f1) 2>/dev/null
done

export WHANOS_DATA_REMOVED="no"
if [[ $1 == "--remove-data" ]]; then
    docker volume rm jenkins_jenkins-data
    docker volume rm registry_registry-data
    export WHANOS_DATA_REMOVED="yes"
fi

rm -R /opt/images
rm -R /opt/tools


echo ""
echo '"I Used the Stones to Destroy the Stones"'
echo ""
echo "Uninstall finished!"
if [[ $WHANOS_DATA_REMOVED == "no" ]]; then
    echo ""
    echo ""
    echo '"As long as there are those that remember what was, there will always be those,'
    echo 'that are unable to accept what can be. They will resist."'
    echo ""
    echo "Data preserved."
fi