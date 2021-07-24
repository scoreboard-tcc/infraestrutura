echo "Aguardando os containers..."

until [ "`docker inspect -f {{.State.Running}} backend`"=="true" ]; do
    sleep 0.1;
done;

echo "Populando dados iniciais no banco..."

docker exec -it backend npx knex seed:run --env development