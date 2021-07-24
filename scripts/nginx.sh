echo "Instalando e configurando o Nginx..."

DOMAIN=scoreboard-tcc.xyz
EMAIL=seuemail@gmail.com

sudo apt install nginx certbot python3-certbot-nginx -y
sudo cp conf/reverse-proxy.conf /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
sudo nginx -t
sudo systemctl reload nginx
sudo certbot --nginx -d server.$DOMAIN -d storage.$DOMAIN -d mqtt.$DOMAIN --email $EMAIL --non-interactive --agree-tos