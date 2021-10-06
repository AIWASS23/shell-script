#!/bin/bash

ARQ_THRESHOLD=/etc/thresholds.env

TIMESTAMP=`date +"%d/%m/%Y-%T"`
DATA_DIA=`date +"%d-%m-%Y"`
HORA_EV=`date +"%T"`
HSTN=`hostname`
UP_TIME=`uptime | awk ' { print $3 } '`
LOAD_AVRG=`cat /proc/loadavg`
LOAD_1=`echo $LOAD_AVRG | awk ' { print $1 } ' | cut -d . -f 1`
LOAD_5=`echo $LOAD_AVRG | awk ' { print $2 } ' | cut -d . -f 1`
LOAD_15=`echo $LOAD_AVRG | awk ' { print $3 } ' | cut -d . -f 1`
WAIT_IO=`/usr/bin/iostat -c  1 3 | tail -2 | head -1 | awk ' { print $4 } ' | cut -d . -f 1`
FS_TODOS=""
ALARMES_COLETADOS=""
LST_FS=`df -PlT | grep -i ext | awk ' { print $7 } '`
ALARME=0

cria_configuracao() {

    if [ -e $ARQ_THRESHOLD ]
    then
        source $ARQ_THRESHOLD
        D_DIR_SCRIPT=$DIR_SCRIPT
	    D_CPU_RQUEUE_THRESHOLD=$CPU_RQUEUE_THRESHOLD
	    D_CPU_IDLE_THRESHOLD=$CPU_IDLE_THRESHOLD
	    D_CPU_WAIT_THRESHOLD=$CPU_WAIT_THRESHOLD
	    D_MEM_PERC_LIVRE_THRESHOLD=$MEM_PERC_LIVRE_THRESHOLD
	    D_LOAD_1_THRESHOLD=$LOAD_1_THRESHOLD
	    D_LOAD_5_THRESHOLD=$LOAD_5_THRESHOLD
	    D_LOAD_15_THRESHOLD=$LOAD_15_THRESHOLD
	    D_FS_PERC_USADO_THRESHOLD=$FS_PERC_USADO_THRESHOLD
	    D_PG_PERC_THRESHOLD=$PG_PERC_THRESHOLD
        D_DEST_MAIL=$DESTINATARIOS
    else
        D_DIR_SCRIPT="`echo ~`/monitora"
        D_CPU_RQUEUE_THRESHOLD=30
        D_CPU_IDLE_THRESHOLD=10
        D_CPU_WAIT_THRESHOLD=30
        D_MEM_PERC_LIVRE_THRESHOLD=10
        D_LOAD_1_THRESHOLD=16
        D_LOAD_5_THRESHOLD=12
        D_LOAD_15_THRESHOLD=8
        D_FS_PERC_USADO_THRESHOLD=80
        D_PG_PERC_THRESHOLD=60
        D_DEST_MAIL=""
    fi

    echo "============================================================"
    echo "Criacao/Reconfiguracao de arquivos de threshold e diretorios"
    echo "Definicao dos thresholds    ================================"
    echo ""

    echo "Definir o diretorio de Configuracao."
    echo "   [ Enter para DEFAULT : $D_DIR_SCRIPT ]"
    read I_D_DIR_SCRIPT
    if [[ $I_D_DIR_SCRIPT = "" ]]
    then
        DIR_SCRIPT=$D_DIR_SCRIPT
    else
        DIR_SCRIPT=$I_D_DIR_SCRIPT
    fi

    echo "Definir Threshold de fila de execucao de CPU."
    echo "   [ Enter para DEFAULT : $D_CPU_RQUEUE_THRESHOLD ]"
    echo "   [ Valores Validos : de 0 a 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_CPU_RQUEUE_THRESHOLD
    if [[ $I_CPU_RQUEUE_THRESHOLD = "" ]]
    then
        CPU_RQUEUE_THRESHOLD=$D_CPU_RQUEUE_THRESHOLD
    else
        CPU_RQUEUE_THRESHOLD=$I_CPU_RQUEUE_THRESHOLD
    fi

    echo "Definir Threshold de CPU Idle."
    echo "   [ Enter para DEFAULT : $D_CPU_IDLE_THRESHOLD ]"
    echo "   [ Valores Validos : de 0 a 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_CPU_IDLE_THRESHOLD
    if [[ $I_CPU_IDLE_THRESHOLD = "" ]]
    then
        CPU_IDLE_THRESHOLD=$D_CPU_IDLE_THRESHOLD
    else
        CPU_IDLE_THRESHOLD=$I_CPU_IDLE_THRESHOLD
    fi


    echo "   [ Enter para DEFAULT : $D_CPU_WAIT_THRESHOLD ]"
    echo "   [ Valores Validos : de 0 a 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_CPU_WAIT_THRESHOLD
    if [[ $I_CPU_WAIT_THRESHOLD = "" ]]
    then
        CPU_WAIT_THRESHOLD=$D_CPU_WAIT_THRESHOLD
    else
        CPU_WAIT_THRESHOLD=$I_CPU_WAIT_THRESHOLD
    fi

    echo "Definir Threshold de perc. de memoria livre."
    echo "   [ Enter para DEFAULT : $D_MEM_PERC_LIVRE_THRESHOLD ]"
    echo "   [ Valores Validos : de 0 a 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_MEM_PERC_LIVRE_THRESHOLD
    if [[ $I_MEM_PERC_LIVRE_THRESHOLD = "" ]]
    then
        MEM_PERC_LIVRE_THRESHOLD=$D_MEM_PERC_LIVRE_THRESHOLD
    else
        MEM_PERC_LIVRE_THRESHOLD=$I_MEM_PERC_LIVRE_THRESHOLD
    fi

    echo "Definir Threshold de Load Average (1 minuto)."
    echo "   [ Enter para DEFAULT : $D_LOAD_1_THRESHOLD ]"
    echo "   [ Valores Validos : A partir de 0 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_LOAD_1_THRESHOLD
    if [[ $I_LOAD_1_THRESHOLD = "" ]]
    then
        LOAD_1_THRESHOLD=$D_LOAD_1_THRESHOLD
    else
        LOAD_1_THRESHOLD=$I_LOAD_1_THRESHOLD
    fi

    echo "Definir Threshold de Load Average (5 minutos)."
    echo "   [ Enter para DEFAULT : $D_LOAD_5_THRESHOLD ]"
    echo "   [ Valores Validos : A partir de 0 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_LOAD_5_THRESHOLD
    if [[ $I_LOAD_5_THRESHOLD = "" ]]
    then
        LOAD_5_THRESHOLD=$D_LOAD_5_THRESHOLD
    else
        LOAD_5_THRESHOLD=$I_LOAD_5_THRESHOLD
    fi

    echo "Definir Threshold de Load Average (15 minutos)."
    echo "   [ Enter para DEFAULT : $D_LOAD_15_THRESHOLD ]"
    echo "   [ Valores Validos : A partir de 0 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_LOAD_15_THRESHOLD
    if [[ $I_LOAD_15_THRESHOLD = "" ]]
    then
        LOAD_15_THRESHOLD=$D_LOAD_15_THRESHOLD
    else
        LOAD_15_THRESHOLD=$I_LOAD_15_THRESHOLD
    fi

    echo "Definir Threshold de percentagem de uso dos Filesystems :"
    echo " $LST_FS "
    echo "   [ Enter para DEFAULT : $D_FS_PERC_USADO_THRESHOLD ]"
    echo "   [ Valores Validos : Entre 0 e 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_FS_PERC_USADO_THRESHOLD
    if [[ $I_FS_PERC_USADO_THRESHOLD = "" ]]
    then 
        FS_PERC_USADO_THRESHOLD=$D_FS_PERC_USADO_THRESHOLD
    else
        FS_PERC_USADO_THRESHOLD=$I_FS_PERC_USADO_THRESHOLD
    fi

    echo "Definir Threshold de uso de Area de Paginacao. "
    echo "   [ Enter para DEFAULT : $D_PG_PERC_THRESHOLD ]"
    echo "   [ Valores Validos : Entre 0 e 100 ]"
    echo "   [ 0 para desativar monitoracao ]"
    read I_PG_PERC_THRESHOLD
    if [[ $I_PG_PERC_THRESHOLD = "" ]]
    then
        PG_PERC_THRESHOLD=$D_PG_PERC_THRESHOLD
    else
        PG_PERC_THRESHOLD=$I_PG_PERC_THRESHOLD
    fi

    echo "Definir destinatarios de e-mail para alertas. "
    echo "Enderecos definidos anteriormente : "
    echo $D_DEST_MAIL
    echo "   [ Entrar com os enderecos, separados por , e sem espacos ]"
    echo "   [ Ou <enter> para manter a lista antiga ]"
    read I_DEST_MAIL
    if [[ $I_DEST_MAIL = "" ]]
    then
        DEST_MAIL=$D_DEST_MAIL
    else
        DEST_MAIL=`echo $I_DEST_MAIL | tr -d " "`
    fi

    sudo touch $ARQ_THRESHOLD
    sudo chown `whoami` $ARQ_THRESHOLD

    echo "DIR_SCRIPT="'"'$DIR_SCRIPT'"' >$ARQ_THRESHOLD
    echo "CPU_RQUEUE_THRESHOLD="$CPU_RQUEUE_THRESHOLD >>$ARQ_THRESHOLD
    echo "CPU_IDLE_THRESHOLD="$CPU_IDLE_THRESHOLD >>$ARQ_THRESHOLD
    echo "CPU_WAIT_THRESHOLD="$CPU_WAIT_THRESHOLD >>$ARQ_THRESHOLD
    echo "MEM_PERC_LIVRE_THRESHOLD="$MEM_PERC_LIVRE_THRESHOLD >>$ARQ_THRESHOLD
    echo "LOAD_1_THRESHOLD="$LOAD_1_THRESHOLD >>$ARQ_THRESHOLD
    echo "LOAD_5_THRESHOLD="$LOAD_5_THRESHOLD >>$ARQ_THRESHOLD
    echo "LOAD_15_THRESHOLD="$LOAD_15_THRESHOLD >>$ARQ_THRESHOLD
    echo "FS_PERC_USADO_THRESHOLD="$FS_PERC_USADO_THRESHOLD >>$ARQ_THRESHOLD
    echo "PG_PERC_THRESHOLD="$PG_PERC_THRESHOLD >>$ARQ_THRESHOLD
    echo "DESTINATARIOS="'"'$DEST_MAIL'"' >>$ARQ_THRESHOLD

    mkdir -p $DIR_SCRIPT
    mkdir -p $DIR_SCRIPT/historico
    cp monitor.sh $DIR_SCRIPT/
    chmod 775 $DIR_SCRIPT/monitor.sh

    echo "Definir o periodo de monitoracao na Cron :"
    echo "   [ Entrar com o intervalo em minutos. Ex. 10 para execucao a cada 10 minutos ]"
    echo "   [ 0 para desativar a cron de monitoracao ]"
    read I_CRON_INTERVAL

    if [[ $I_CRON_INTERVAL = 0 ]]
    then
        crontab -l | grep -v "##Monitoracao do" | grep -v "/monitor.sh" >/tmp/cron.tmp
        cat /tmp/cron.tmp | crontab -
    else
        crontab -l | grep -v "##Monitoracao do" | grep -v "/monitor.sh" >/tmp/cron.tmp
        echo "##Monitoracao do servidor a cada $I_CRON_INTERVAL Minutos" >>/tmp/cron.tmp
        echo "*/"$I_CRON_INTERVAL" * * * * $DIR_SCRIPT/monitor.sh 1>>/dev/null 2>>/dev/null" >>/tmp/cron.tmp
        cat /tmp/cron.tmp | crontab -
        rm -f /tmp/cron.tmp
    fi

    echo ""
    echo ""
    echo "=============================================================="
    echo "Criacao de arquivos de thresholds finalizado"
exit
}

clear

if [[ $1 = "-configurar" ]]
then
   echo "Criar config!!!"
   cria_configuracao 
fi

if [ -e $ARQ_THRESHOLD ]
then
   echo "Verificando config - OK!"
   echo "Carregando thresholds"
   echo "Distribuicao Linux baseado em $LINUX_DISTRO "
   source $ARQ_THRESHOLD
else   
   echo "Arquivo de Threshold nao encontrado !"
   echo "Rodar o shell script com a opcao -configurar :"
   echo "./monitor.sh -configurar"
   sleep 3
   exit
fi

ARQ_MAIL="$DIR_SCRIPT/mail.txt"
ARQ_HISTORICO="$DIR_SCRIPT/historico/HISTORICO_$DATA_DIA.txt"
ARQ_ALARME="$DIR_SCRIPT/ALARMES.txt"


if [ -e $ARQ_ALARME ]
then
    XX="ARQ. Existe"
else
    echo "0,0,0,0,0,0,0" >>$ARQ_ALARME
fi

mv $ARQ_ALARME $ARQ_ALARME.tmp
tail -600 $ARQ_ALARME.tmp >$ARQ_ALARME

printf "\n" >$ARQ_MAIL
printf " ----- EMAIL DE ALERTA ----- \n" >>$ARQ_MAIL
printf "  Servidor                 : $HSTN\n" >>$ARQ_MAIL
printf "  Data/Hora do evento      : $TIMESTAMP\n" >>$ARQ_MAIL
printf "  Uptime da Maquina        : $UP_TIME dias\n"  >>$ARQ_MAIL
printf "  Recurso(s) Monitorado(s) : CPU (Fila de Execucao, Idle e CPU Wait), MEMORIA, PAGINACAO, LOAD AVERAGE, WAIT IO E FILESYSTEMS\n" >>$ARQ_MAIL
printf "\n" >>$ARQ_MAIL
printf "Eventos :\n" >>$ARQ_MAIL
