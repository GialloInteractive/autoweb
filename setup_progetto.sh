#!/bin/bash

# Controllo dei parametri
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 nome_progetto nome_dominio database tipologia"
    exit 1
fi

nome_progetto=$1
nome_dominio=$2
database=$3
tipologia=$4

# 1) Verifica se nginx è installato e se non è installato installarlo
if ! command -v nginx &> /dev/null; then
    echo "Nginx non è installato. Installazione in corso..."
    sudo apt update
    sudo apt install -y nginx
fi

# 2) Creare la cartella in /var/www/html/ con il nome del progetto
sudo mkdir -p /var/www/html/$nome_progetto

# 3) Creare il file di configurazione di nginx in base alla tipologia (php,nodejs o flusk) con il dominio indicato nel relativo parametro
case $tipologia in
    php)
        conf="location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        }"
        ;;
    nodejs)
        conf="location / {
            proxy_pass http://localhost:3000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host \$host;
            proxy_cache_bypass \$http_upgrade;
        }"
        ;;
    flask)
        conf="location / {
            proxy_pass http://localhost:5000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host \$host;
            proxy_cache_bypass \$http_upgrade;
        }"
        ;;
    *)
        echo "Tipologia non valida. Valori accettabili: php, nodejs, flask"
        exit 1
        ;;
esac

sudo bash -c "cat > /etc/nginx/sites-available/$nome_progetto << EOF
server {
    listen 80;
    server_name $nome_dominio;
    root /var/www/html/$nome_progetto;

    index index.html index.htm index.nginx-debian.html;

    $conf
}
EOF"

# 4) Creare i link simbolici
sudo ln -s /etc/nginx/sites-available/$nome_progetto /etc/nginx/sites-enabled/

# 5) Se il parametro database ha valore si, installare mysql
if [ "$database" = "si" ]; then
    echo "Installazione di MySQL in corso..."
    sudo apt update
    sudo apt install -y mysql-server
fi

# 6) Riavviare i servizi necessari
sudo systemctl restart nginx
