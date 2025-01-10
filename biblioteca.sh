#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Acest script trebuie rulat ca root" 
   exit 1
fi

install_web_server() {
    bash install.sh
}

manage_data() {
    bash data_management.sh
}

socket_communication() {
    bash socket_communication.sh
}

while true; do
    echo "
    Aplicație de Management al Bibliotecii
    1. Instalare server web
    2. Gestionare date utilizatori
    3. Comunicare prin sockets
    4. Ieșire
    "
    read -p "Alegeți o opțiune: " choice
    case $choice in
        1) install_web_server ;;
        2) manage_data ;;
        3) socket_communication ;;
        4) exit 0 ;;
        *) echo "Opțiune invalidă" ;;
    esac
done
