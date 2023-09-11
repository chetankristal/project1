docker network create   --scope=swarm   --driver=overlay   --subnet=20.0.37.0/24   --gateway=20.0.37.1   my-overlay

docker stack deploy -c docker_stack_node.yaml --with-registry-auth prod-frontend
#sleep 5
#docker system prune -f

