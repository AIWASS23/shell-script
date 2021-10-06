#!/bin/bash

media=""
soma=""
clear

echo -e "\f\t\t\t\fcalculando a media de alunos\n"

echo -e "\tDigite o nome do aluno"
read aluno

echo -e "\tDigite o sobrenome do aluno"
read sobrenome

echo -e "\tDigite a quantidade de notas: "
read notas

while [ $notas -le 0 ]
do
     echo -e "\tQuantidade de notas invalida entre com outro valor"
     read notas
done

echo -e "\tDigite as notas entre 0-10 "
   for ((a=1; a<=$notas; a="(($a+1))")){
        echo -e "\tDigite a $a nota"
          while read contas[$a]
          do  
             case ${contas[$a]} in
                [0-9]) break;;
                10) break;;
                esac
        echo -e "\tO valor deve ser de 0-10"
        done
        soma=`expr $soma + ${contas[$a]} `
   }
   
media=`expr $soma / $notas`
echo -e "\tA media de $aluno $sobrenome é $media "
if [ $media -gt 6 ]; then
       echo -e "\tO $aluno $sobrenome esta aprovado"
  else
       echo -e "\tO $aluno $sobrenome esta reprovado"
