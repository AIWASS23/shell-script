#!/bin/bash

if [ $LOAD_1_THRESHOLD = 0 ]
then
    MONIT="Threshold Desativado"
else
   if [ $LOAD_1 -ge $LOAD_1_THRESHOLD ]
   then
      printf "\n" >>$ARQ_MAIL
      echo "Load Average 1 Min. : $LOAD_1 " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$LOAD_1"
      ALARME=1
   fi
fi

if [ $LOAD_5_THRESHOLD = 0 ]
then
   MONIT="Threshold Desativado"
else
   if [ $LOAD_5 -ge $LOAD_5_THRESHOLD ]
   then
      printf "\n" >>$ARQ_MAIL
      echo "Load Average 5 Min. : $LOAD_5 " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$LOAD_5"
      ALARME=1
   fi
fi


if [ $LOAD_15_THRESHOLD = 0 ]
then
   MONIT="Threshold Desativado"
else
   if [ $LOAD_15 -ge $LOAD_15_THRESHOLD ]
   then
      printf "\n" >>$ARQ_MAIL
      echo "Load Average 15 Min. : $LOAD_15 " >>$ARQ_MAIL
      ALARMES_COLETADOS="$ALARMES_COLETADOS,$LOAD_15"
     ALARME=1
   fi
fi
