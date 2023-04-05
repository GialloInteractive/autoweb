# autoweb
# Script di configurazione del progetto

Questo script Bash consente di configurare automaticamente un progetto web con Nginx e, se richiesto, installare MySQL. Supporta i seguenti tipi di progetti: PHP, Node.js e Flask.

## Requisiti

- Sistema operativo basato su Debian (ad esempio Ubuntu)
- Privilegi di amministratore (sudo)

## Istruzioni

1. Scarica o copia lo script `setup_progetto.sh` nel tuo sistema.

2. Rendi lo script eseguibile con il comando:

chmod +x setup_progetto.sh

3. Esegui lo script con i parametri richiesti:

./setup_progetto.sh nome_progetto nome_dominio database tipologia

Ad esempio:

./setup_progetto.sh mio_progetto esempio.com si php

Questo comando configurerà un progetto PHP chiamato "mio_progetto" con il dominio "esempio.com" e installerà MySQL.

Sostituisci i parametri con i valori appropriati per il tuo progetto:

- `nome_progetto`: il nome del tuo progetto.
- `nome_dominio`: il dominio in cui il progetto sarà disponibile.
- `database`: specifica "si" per installare MySQL, altrimenti "no".
- `tipologia`: il tipo di progetto. Valori accettabili: "php", "nodejs" o "flask".

4. Lo script installerà e configurerà Nginx, creerà la cartella del progetto, configurerà il server in base alla tipologia specificata e, se richiesto, installerà MySQL.

5. Dopo l'esecuzione dello script, carica i file del tuo progetto nella cartella `/var/www/html/nome_progetto` (dove "nome_progetto" è il nome del tuo progetto).

6. Assicurati di aver configurato correttamente il DNS per il tuo dominio affinché punti al tuo server.

## Note

- Lo script deve essere eseguito con privilegi di amministratore (sudo).
- Assicurati di eseguire l'aggiornamento del sistema e l'installazione dei pacchetti necessari per la tipologia del progetto (ad esempio, PHP-FPM per progetti PHP, Node.js e npm per progetti Node.js, ecc.).
