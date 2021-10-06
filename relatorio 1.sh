joari@joari - VirtualBox: ~/Desktop$ nano relatorio.sh

#!/bin/bash

echo "MENU"
echo "1) nome_familiares"
echo "2) data_nascimento"
echo "3) listagem"
echo "4) mensagem"
read MENU

case $MENU in

    1) nome_familiares(){
         echo "Digite o sobrenome da familia"
         read SOBRENOME

         echo "Digite a quantidade de pessoas na familia"
         read NUMEROFAMILIARES

         for((PIVO = 1; PIVO <= $NUMEROFAMILIARES; PIVO++))
         do
            echo "Informe o nome do familiar $PIVO"
            read NOME

            echo "$NOME $SOBRENOME"
         done
    }

    2) data_nascimento(){
         echo "Informe o dia do seu nascimento"
         read DIA

         echo "Informe o mes do seu nascimento"
         read MES

         echo "Informe o ano do seu nascimento"
         read ANO

         echo "$DIA - $MES - $ANO"
    }

    3) listagem(){
         echo "Digite um numero"
         read NUMERO

         for((PIVO = 1; PIVO <= $NUMERO; PIVO++))
         do
            echo -ne "$PIVO "
         done
    }   

    4) messagem(){
         echo "Escreva uma frase" >> memorias.txt
    }

    *) echo "Opção invalida"
esac 
