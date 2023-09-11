
docker stack deploy -c ~/docker-stack-node.yml --with-registry-auth kristal-batchapps
sleep 5
docker system prune -f

