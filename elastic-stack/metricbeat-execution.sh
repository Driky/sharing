#!/bin/bash

 ###
 #   Auteur: tony.blanchard@zenika.com
 ###

TRANSPARENT='\e[0m'
VERT='\033[0;32m'
OS=`uname`
EXEC=`find . -type f -name metricbeat | grep metricbeat | grep -v logs/metricbeat | grep -i $OS`
CONF=`find . -type f -name metricbeat.yml | grep -i tps/metricbeat/$OS`

clear

echo 
echo -e ${VERT}"Démarrage du processus demandé..."${TRANSPARENT}

echo 
echo Installation du dashboard kibana
echo -e ${VERT}"$EXEC setup"${TRANSPARENT}
$EXEC setup -c $CONF

echo 
echo -e ${VERT}"$EXEC -e -c $CONF"${TRANSPARENT}
$EXEC -e -c $CONF
