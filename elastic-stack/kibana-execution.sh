#!/bin/bash

 ###
 #   Auteur: tony.blanchard@zenika.com
 ###

TRANSPARENT='\e[0m'
VERT='\033[0;32m'
OS=`uname`
EXEC=`find . -name kibana | grep bin/kibana | grep -i $OS`
PID_FILE='kibana.pid'

clear
if [ "$OS" = "Darwin" ]
then
  OPEN_CMD=open
else
  OPEN_CMD=xdg_open
fi


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

  ./$EXEC &
  echo $! > $PID_FILE

  sleep 8

  echo
  echo -e ${VERT}"Affichage de la page d'accueil..."${TRANSPARENT}
  echo
  $OPEN_CMD http://localhost:5601 &
fi
