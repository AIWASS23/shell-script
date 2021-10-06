joari@joari - VirtualBox: ~/Desktop$ nano progressao.sh

#!/bin/bash
SOMA=0
PIVO=0
echo " Soma na progressão"

echo " Digite o primeiro numero: "
read NUM1
echo " Digite o segundo numero: "
read NUM2

while [ $NUM1 -lt $NUM2 ]
do
    echo " O segundo numero tem q ser maior do q o primeiro"
done

for (( PIVO=$NUM1; PIVO<$NUM2+1; PIVO++))
do
   SOMA=$(($SOMA+$PIVO))
done

echo " A soma da progressão é: $SOMA "
