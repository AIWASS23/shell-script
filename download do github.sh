#!/bin/sh

echo "*************************************"
echo "* Sistema de Carregamento de Codigo *"
echo "*************************************"
echo "*"

export id=1
read -p "* Selecione o numemo do arquivo " id

export areyousure="N"
read -p "* Deseja realmente deletar a pasta lib e baixar o codigo $id (S/[N])?" areyousure

case $areyousure in
    [Nn]* ) exit;;
    [Ss]* )
        echo "* Removendo a pasta lib"
        rm -rf lib

        echo "* Buscando o codigo  $id"

        git clone https://github.com/ lib # digite o link do github
        if [ $? -ne 0 ]; then
            echo "* Nao foi possivel carregar codigo do GitHub"
            exit
        fi

        cd lib
        git checkout $id

        if [ $? -ne 0 ]; then
            echo "* Selecione um codigo valido"
            cd ..
            rm -rf lib
            exit
        fi

        echo "* Codigo $id carregado com sucesso!"
        cd ..
    ;;
    * ) exit;;
esac