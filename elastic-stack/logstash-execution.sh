#!/bin/bash

 ###
 #   Auteur: tony.blanchard@zenika.com
 ###

TRANSPARENT='\e[0m'
VERT='\033[0;32m'
EXEC=`find . -name logstash | grep bin/logstash`
CONF=`find . -name config | grep logstash/config | grep -v /lib/`

clear

echo 
echo -e ${VERT}"Démarrage du processus demandé..."${TRANSPARENT}
echo 
echo -e ${VERT}"logstash --config.reload.automatic -f $CONF/*"${TRANSPARENT}

./$EXEC --config.reload.automatic -f $CONF/* 
