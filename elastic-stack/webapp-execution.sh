#!/bin/bash

 ###
 #   Auteur: tony.blanchard@zenika.com
 ###

TRANSPARENT='\e[0m'
VERT='\033[0;32m'
cd tps/applicationWeb
EXEC="web-app.jar"
PID_FILE='webapp.pid'

clear

if [ -f $PID_FILE ]
then
  PID=$(<$PID_FILE)
  echo
  echo -e ${VERT}"Arrêt du processus: >> "$PID${TRANSPARENT}
  echo
  kill $PID
  sleep 2 
  rm -f $PID_FILE
else
  echo
  echo -e ${VERT}"Aucun processus à stopper..."${TRANSPARENT}
  echo
fi


if [ -z $1 ]
then
	echo 
	echo -e ${VERT}"Démarrage du processus demandé..."${TRANSPARENT}
	
	echo 
	echo -e ${VERT}"java -jar $EXEC"${TRANSPARENT}
	java -jar $EXEC &
	echo $! > $PID_FILE
	
	sleep 8
	
	echo
	echo -e ${VERT}"Affichage de la page d'accueil de l'application de génération des logs..."${TRANSPARENT}
	echo
	xdg-open http://localhost:8080 &
fi