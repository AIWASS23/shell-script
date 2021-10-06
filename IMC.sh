#!/bin/bash
echo "Digite o peso da pessoa em KG:"
read peso

echo "Digite a altura da pessoa em metros :"
read altura

echo

imc=`echo "scale=2; $peso / ( $altura ^ 2 )" | bc -l`
nimc=`echo "scale=2; $peso / ( $altura ^ 2 )" | bc -l | sed 's/\.//'`

if [ $nimc -lt 1700 ] ; then
echo "Cuidado! $nome está muito abaixo do peso"
elif [ $nimc -ge 1700 ] && [ $nimc -le 1849 ] ; then
echo "$nome está abaixo do peso"
elif [ $nimc -gt 1849 ] && [ $nimc -le 2499 ] ; then
echo "Parabéns! $nome está dentro do peso ideal"
elif [ $nimc -gt 2499 ] && [ $nimc -le 2999 ] ; then
echo "$nome está acima do peso ideal"
elif [ $nimc -gt 2999 ] && [ $nimc -le 3499 ] ; then
echo "Cuidado! $nome está com Obesidade nível I"
elif [ $nimc -gt 3499 ] && [ $nimc -le 3999 ] ; then
echo "Cuidado! $nome está com Obesidade nível II (severa)."
elif [ $nimc -gt 3999 ] ; then
echo "Cuidado! $nome está com Obesidade nível III (mórbida)."
else
echo "Erro"
echo "com o IMC igual a $imc"
echo
