#!/bin/bash

ACUM=$1;

while [ $ACUM -gt 0 ]
do
    echo "valor $ACUM"
    ACUM=$(($ACUM-1))
done

for ((i=0; i<$2; i++))
do
    ACUM=$(($ACUM*$1))
done
echo " $ACUM";

case $1 in
+) echo "$(($2+1))";;
d) echo "$(($2/2))";;
*) echo "$2"
    exit;;
esac

if [ $1 -gt 10 -a $(($1 % 2)) -eq 0]
then
    echo "$(($1/2))"
else 
    if [ $(($1 % 2)) -eq 0 ]
    then
        echo "$(($1+1))"
    else
        echo "$(($1-1))"
    fi
fi

soma(){
    echo "$(($1+1))"
}
diminuir(){
    echo "$(($1-1))"
}
dividePor2(){
    echo "$(($1/2))"
}
imprime(){
    echo "$1"
}

case $1 in
+) soma $2;;
-) diminuir $2;;
d) dividePor2 $2;;
*) imprime $2
    exit;;
esac
















