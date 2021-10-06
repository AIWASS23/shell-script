#!/bin/bash

COLETA_CPU=`vmstat 1 3 | awk ' { print $1","$15","$16 } ' | tail -1`
CPU_RQUEUE=`echo $COLETA_CPU | cut -d , -f 1`
CPU_IDLE=`echo $COLETA_CPU | cut -d , -f 2`
CPU_WAIT=`echo $COLETA_CPU | cut -d , -f 3`

if [ $CPU_RQUEUE_THRESHOLD -eq 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $CPU_RQUEUE -ge $CPU_RQUEUE_THRESHOLD ]
   then
      printf "Fila de Execucao de CPU maior que o esperado : $CPU_RQUEUE \n" >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$CPU_RQUEUE"
      ALARME=1
   fi
fi

if [ $CPU_IDLE_THRESHOLD -eq 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $CPU_IDLE_THRESHOLD -ge $CPU_IDLE ]
   then
      echo "Uso de CPU : $CPU_IDLE % de CPU Livre " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$CPU_IDLE"
      ALARME=1
   fi
fi

if [ $CPU_WAIT_THRESHOLD -eq 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $CPU_WAIT -ge $CPU_WAIT_THRESHOLD ]
   then
      printf "Taxa de Waiting :  CPU WAIT = $CPU_WAIT \n" >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$CPU_WAIT"
      ALARME=1
   fi
fi
