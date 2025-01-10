#!/bin/bash

PORT=8080
TIMEOUT=30
SERVER_PID=""

start_server() {
    if [ -n "$SERVER_PID" ]; then
        echo "Serverul este deja pornit (PID: $SERVER_PID)"
        return
    fi
    echo "Pornire server pe portul $PORT..."
    (
        while true; do
            message=$(timeout $TIMEOUT nc -l -p $PORT)    
            if [ $? -eq 124 ]; then
                echo "Timeout: Niciun mesaj primit în $TIMEOUT secunde. Serverul rămâne activ."
                continue
            fi
            echo "Mesaj primit: $message"
            echo "Răspuns trimis la $(date)" | nc -l -p $PORT -w 1    
        done
    ) &
    SERVER_PID=$!
    echo "Server pornit cu PID: $SERVER_PID"
}

stop_server() {
    if [ -n "$SERVER_PID" ]; then
        echo "Oprire server (PID: $SERVER_PID)..."
        kill $SERVER_PID
        SERVER_PID=""
    else
        echo "Serverul nu este pornit."
    fi
}

send_message() {
    echo "Introduceți mesajul de trimis (sau 'q' pentru a reveni la meniu):"
    read message
    [ "$message" = "q" ] && return
    echo "$message" | nc -w 5 localhost $PORT || { echo "Eroare: Serverul nu răspunde."; return; }
    response=$(timeout 5 nc localhost $PORT)
    if [ $? -eq 124 ]; then
        echo "Timeout: Nu s-a primit niciun răspuns de la server."
    else
        echo "Răspuns primit: $response"
    fi
}

trap 'stop_server; echo "Program întrerupt. La revedere!"; exit 0' INT

while true; do
    echo "
    Comunicare prin Sockets
    1. Pornește server
    2. Trimite mesaj (client)
    3. Oprește server
    4. Ieșire
    "
    read -p "Alegeți o opțiune: " choice
    case $choice in
        1) start_server ;;
        2) send_message ;;
        3) stop_server ;;
        4) stop_server; echo "La revedere!"; exit 0 ;;
        *) echo "Opțiune invalidă" ;;
    esac
done
