# Documentație Scripturi Proiect Bibliotecă

Acest document descrie scripturile folosite în proiectul de management al bibliotecii, adaptate pentru sisteme Linux.

## install.sh

Acest script este responsabil pentru instalarea și configurarea serverului web Apache pe un sistem Linux. Principalele funcționalități includ:

- Verificarea privilegiilor de root pentru asigurarea permisiunilor necesare.
- Implementarea unui mecanism de gestionare a erorilor pentru o execuție mai sigură.
- Actualizarea sistemului și instalarea pachetelor necesare (Apache2 și UFW).
- Pornirea și activarea serviciului Apache2.
- Crearea unei pagini web personalizabile, cu input de la utilizator pentru titlu și mesaj de bun venit.
- Configurarea și activarea firewall-ului UFW pentru a permite traficul HTTP.
- Verificarea finală a stării serviciului Apache2.

Scriptul utilizează comenzi specifice sistemelor bazate pe Debian, cum ar fi `apt` pentru gestionarea pachetelor și `systemctl` pentru controlul serviciilor. Utilizează, de asemenea, `ufw` pentru configurarea simplificată a firewall-ului.

## data_management.sh

Acest script gestionează datele utilizatorilor bibliotecii, oferind un sistem interactiv de management al informațiilor. Principalele funcționalități includ:

- Adăugarea de noi utilizatori cu validare a input-ului
- Afișarea listei de utilizatori existenți într-un format ușor de citit
- Ștergerea utilizatorilor existenți
- Gestionarea automată a fișierului de date

Caracteristici cheie:

1. Stocarea datelor: Utilizează un fișier text (/var/www/html/users.txt) pentru a stoca informațiile utilizatorilor.

2. Validarea input-ului: Implementează verificări pentru a asigura că numele utilizatorilor conțin doar caractere permise și că vârsta este un număr valid.

3. Afișare formatată: Folosește awk pentru a prezenta datele utilizatorilor într-un format tabelar ușor de citit.

4. Ștergerea utilizatorilor: Permite eliminarea selectivă a utilizatorilor din baza de date.

5. Meniu interactiv: Oferă o interfață în linia de comandă pentru accesarea tuturor funcționalităților.

6. Gestionarea erorilor: Include verificări pentru existența fișierului de date și gestionează cazurile în care nu există utilizatori înregistrați.

Scriptul este proiectat să fie robust și ușor de utilizat, oferind o soluție completă pentru gestionarea datelor utilizatorilor într-o bibliotecă, folosind exclusiv utilitare Bash și comenzi Linux standard.
Datele sunt stocate într-un fișier text pe sistemul de operare. Scriptul oferă un meniu interactiv pentru aceste operațiuni.

## socket_communication.sh

Acest script implementează o comunicare bidirecțională prin sockets, facilitând schimbul de mesaje între un server și clienți. Principalele funcționalități includ:

- Un server de socket configurat să asculte pe portul 8080
- Un client de socket pentru trimiterea și primirea mesajelor
- Un meniu interactiv pentru alegerea între modul server și client

Caracteristici cheie:

1. Timeout-uri: Implementează timeout-uri atât pentru server cât și pentru client pentru a evita blocajele și a îmbunătăți gestionarea erorilor.

2. Gestionarea erorilor: Include verificări pentru conexiuni eșuate și timeout-uri, oferind feedback utilizatorului.

3. Flexibilitate: Permite utilizatorului să revină la meniu din modul client fără a închide programul.

4. Întrerupere grațioasă: Implementează un handler pentru semnalul SIGINT (Ctrl+C), permițând închiderea controlată a programului.

5. Configurabilitate: Utilizează variabile pentru port și timeout, facilitând ajustările rapide.

Scriptul utilizează comanda `nc` (netcat) pentru implementarea comunicării prin sockets, demonstrând o utilizare avansată a acestui utilitar în contextul programării în shell.

Această implementare oferă o bază solidă pentru comunicarea în rețea, fiind utilă în scenarii de testare, debugging sau ca parte a unor aplicații mai complexe care necesită comunicare între procese.

## biblioteca.sh

Acesta este scriptul principal care integrează toate funcționalitățile proiectului. Oferă un meniu interactiv pentru:

- Instalarea serverului web
- Gestionarea datelor utilizatorilor
- Inițierea comunicării prin sockets

Scriptul apelează celelalte scripturi (`install.sh`, `data_management.sh`, `socket_communication.sh`) în funcție de opțiunea aleasă de utilizator.