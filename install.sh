#!/bin/bash

set -e

[[ $EUID -ne 0 ]] && { echo "Acest script trebuie rulat ca root"; exit 1; }

handle_error() {
    echo "Eroare: $1" >&2
    exit 1
}

apt update && apt upgrade -y || handle_error "Actualizarea sistemului a eșuat"
apt install apache2 ufw -y || handle_error "Instalarea pachetelor a eșuat"

systemctl start apache2 && systemctl enable apache2 || handle_error "Configurarea Apache2 a eșuat"

read -p "Titlul paginii web: " page_title
read -p "Mesaj de bun venit: " welcome_message

cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$page_title</title>
</head>
<body>
    <h1>$welcome_message</h1>
</body>
</html>
EOF

ufw allow 80/tcp && ufw --force enable || handle_error "Configurarea firewall-ului a eșuat"

systemctl is-active --quiet apache2 && echo "Instalarea serverului web s-a încheiat cu succes." || handle_error "Apache2 nu rulează"
