#!/bin/bash

PG_TOTAL=$((`/usr/bin/free -m | grep "Swap:" | awk ' { print $3 } '`*100))
PG_USO=`/usr/bin/free -m | grep "Swap:" | awk ' { print $4 } '`
PG_PERC=$(($PG_TOTAL/$PG_USO))

if [ $PG_PERC_THRESHOLD = 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $PG_PERC -ge $PG_PERC_THRESHOLD ]
   then
      printf "\n" >>$ARQ_MAIL
      echo "Uso de Area de Paginacao : $PG_PERC % Utilizado " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$PG_PERC"
      ALARME=1
   fi
fi
