#!/bin/bash

COLETA_MEMORIA=`/usr/bin/free -m | grep "Mem:" | awk ' { print $3","$4 } '`
MEM_TT_USADO=`echo $COLETA_MEMORIA | cut -d , -f 1`
MEM_TT_LIVRE=`echo $COLETA_MEMORIA | cut -d , -f 2`
MEM_PERC_LIVRE=$(($MEM_TT_LIVRE*100/$MEM_TT_USADO))


if [ $MEM_PERC_LIVRE_THRESHOLD = 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $MEM_PERC_LIVRE -lt $MEM_PERC_LIVRE_THRESHOLD ]
   then
      echo "Uso de memoria : $MEM_PERC_LIVRE % Livre " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$MEM_PERC_LIVRE"
      ALARME=1
    fi
fi
