#!/bin/bash

DATA_FILE="/var/www/html/users.txt"

validate_input() {
    [[ $1 =~ ^[a-zA-Z0-9_]+$ ]] || return 1
}

add_user() {
    local name age
    while true; do
        read -p "Introduceți numele utilizatorului: " name
        validate_input "$name" && break
        echo "Nume invalid. Folosiți doar litere, cifre și underscore."
    done
    while true; do
        read -p "Introduceți vârsta utilizatorului: " age
        [[ $age =~ ^[0-9]+$ ]] && break
        echo "Vârstă invalidă. Introduceți doar cifre."
    done
    echo "$name:$age" >> "$DATA_FILE"
    echo "Utilizator adăugat cu succes."
}

show_users() {
    if [[ -f "$DATA_FILE" ]]; then
        echo "Lista utilizatorilor:"
        awk -F: '{printf "Nume: %-20s Vârsta: %s\n", $1, $2}' "$DATA_FILE"
    else
        echo "Nu există utilizatori înregistrați."
    fi
}

delete_user() {
    read -p "Introduceți numele utilizatorului de șters: " name
    if grep -q "^$name:" "$DATA_FILE"; then
        sed -i "/^$name:/d" "$DATA_FILE"
        echo "Utilizatorul $name a fost șters."
    else
        echo "Utilizatorul $name nu a fost găsit."
    fi
}

while true; do
    echo "
    Gestionare Utilizatori
    1. Adaugă utilizator
    2. Afișează utilizatori
    3. Șterge utilizator
    4. Ieșire
    "
    read -p "Alegeți o opțiune: " choice
    case $choice in
        1) add_user ;;
        2) show_users ;;
        3) delete_user ;;
        4) exit 0 ;;
        *) echo "Opțiune invalidă" ;;
    esac
done
