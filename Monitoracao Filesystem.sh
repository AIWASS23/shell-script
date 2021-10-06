#!/bin/bash

if [ $FS_PERC_USADO_THRESHOLD = 0 ]
then
   MONIT="Threshold Desativado"
else
   for FS in $LST_FS
   do
      FS_PERC_USADO=`df -P $FS  | awk ' { print $5 } ' | tail -1 | tr -d "%"`
      if [ $FS_PERC_USADO -ge $FS_PERC_USADO_THRESHOLD ]
      then
         printf "\n" >>$ARQ_MAIL
         echo "Uso de Filesystem : $FS esta com $FS_PERC_USADO % de Utilizacao " >>$ARQ_MAIL
         ALARMES_COLETADOS="$ALARMES_COLETADOS,$FS_PERC_USADO"
         ALARME=1
      fi
      FS_TODOS="$FS_TODOS$FS : $FS_PERC_USADO,"
   done
fi

echo $ALARMES_COLETADOS >>$ARQ_ALARME
printf "\n \n " >>$ARQ_MAIL
echo "Este e um e-mail automatico gerado por script, por favor nao responda" >>$ARQ_MAIL

if [ -f $ARQ_HISTORICO ]
then
   HISTORICO_ARQUIVO="Arquivo Encontrado"
else
   echo "Data,Hora,Hostname,CPU RunQueue,CPU Idle,CPU Wait,MEM Livre,Uso PAGINACAO,LOAD 1min.,LOAD 5min.,LOAD 15min,FILESYSTEMS" >>$ARQ_HISTORICO
fi

echo "$DATA_DIA,$HORA_EV,$HSTN,$CPU_RQUEUE,$CPU_IDLE,$CPU_WAIT,$MEM_PERC_LIVRE,$PG_PERC,$LOAD_1,$LOAD_5,$LOAD_15,$FS_TODOS" >>$ARQ_HISTORICO


if [ $ALARME -eq 1 ]
then
   if [[ $ALARMES_COLETADOS != `tail -2 $ARQ_ALARME | head -1` ]]
   then
        mailx -s "Monitoracao Linux - $HSTN - $TIMESTAMP" -v $DESTINATARIOS <$ARQ_MAIL
   fi
fi
