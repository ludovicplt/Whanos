if [ ! -f .env ]; then
    cp .env.default
fi

docker-compose down
rm -rf ./jenkins-certs
docker-compose up --build --force-recreate --remove-orphans
docker rmi runner