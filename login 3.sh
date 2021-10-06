joari@joari - VirtualBox: ~/Desktop$ nano login.sh

#!/bin/bash

$1="joari"
$2=123

if[$1="joari" -a $2=123];then
    echo "Bem-vindo ao sistema"
else
    echo "Usuário e Senha incorreta, encerrando o script "
fi

echo "Informe o usuário: "
read USUARIO

echo "Informe a senha: "
read SENHA

if [$USUARIO="joari" -a $SENHA=123]; then
    echo "Bem-vindo ao sistema"
else
    echo "Usuário e Senha incorreta, encerrando o script "
fi

echo "O que deseja fazer? 
echo "1. Criar uma pasta"
echo "2. Criar um arquivo"
echo "3. Qual número é maior?"
echo "4. Sair do programa"
read NUM
case "$NUM" in
   1) mkdir joari;;  
   2) touch joari.txt ;;
   3) echo " Informe 2 numeros: "
        read NUM1
        read NUM 2
        test NUM1 -gt NUM2 && echo "O maior número é: $NUM1
        test NUM2 -gt NUM1 && echo "O maior número é: $NUM2 
        test NUM1 -eq NUM2 && echo "Os 2 números são iguais :| ;; 
    4) echo "Obrigado por usar o programa" ;;
    *) echo "Opção inválida";; 
esac