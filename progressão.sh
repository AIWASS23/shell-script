joari@joari - VirtualBox: ~/Desktop$ nano progressao.sh

#!/bin/bash
SOMA=0
CONTADOR=0
MEDIA=0
MAIOR=0
MENOR=0 
AUX=0
CONTADOR1=0

echo " Digite uma idade e para encerrar o numeros de idades digite 0"
read IDADE

while [ $IDADE -ne 0 ]
do
    echo " Digite uma idade"
    read IDADE
    CONTADOR++
done
for((PIVO=0; PIVO<CONTADOR+1; PIVO++))
do
   SOMA=$(($SOMA+$IDADE))
   MEDIA=$(($SOMA/$CONTADOR))
   echo " A media das idades é: $MEDIA"
done

for((X=1; X<CONTADOR+1; X++))
do
   if [ $IDADE -gt $MAIOR ]
   then
       AUX=$IDADE
       IDADE=$MAIOR
       MAIOR=$AUX
   fi
    if [ $IDADE -lt $MENOR ] 
   then
       AUX=$IDADE
      IDADE=$MENOR 
      MENOR=$AUX
   fi 
    if [ $IDADE -gt 18 ]
   then
       CONTADOR1++
   fi
  echo "O maior número é: $MAIOR" 
  echo "O maior número é: $MENOR"
  echo "O número de idades acima de 18 é: $CONTADOR1"
done