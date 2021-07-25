read -p "Digite o domínio (ex: meudominio.com): " domain
read -p "Digite um e-mail (necessário para gerar os certificados): " email

sed -i "s|scoreboardapp.tech|$domain|g" conf/reverse-proxy.conf

echo "Instalando o Docker..."

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
sudo apt install docker-compose -y
newgrp docker <<EONG
docker-compose up -d

echo "Instalando e configurando o Nginx..."

sudo apt install nginx certbot python3-certbot-nginx -y
sudo cp conf/reverse-proxy.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
sudo nginx -t
sudo systemctl reload nginx
sudo certbot --nginx -d server.$domain -d storage.$domain -d mqtt.$domain --email $email --non-interactive --agree-tos

echo "Aguardando os containers..."

until [ "`docker inspect -f {{.State.Running}} backend`"=="true" ]; do
    sleep 0.1;
done;

echo "Populando dados iniciais no banco..."

docker exec -it backend npx knex seed:run --env development

echo "PATH=$PATH" > /etc/cron.d/certbot-renew
echo "@monthly certbot renew --nginx >> /var/log/cron.log 2>&1" >>/etc/cron.d/certbot-renew
crontab /etc/cron.d/certbot-renew
EONG


