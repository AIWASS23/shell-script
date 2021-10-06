joari@joari - VirtualBox: ~/Desktop$ nano tabuada.sh

#!/bin/bash

echo "Digite um numero para calcular sua tabuada:"
read NUM

for ((PIVO=1; PIVO<11; PIVO++))
do
echo -ne "TABUADA :  $(($NUM*PIVO))"
done
