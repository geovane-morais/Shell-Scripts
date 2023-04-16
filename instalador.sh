#!/bin/bash
#Instalando software:
#cria uma pasta software na diretiva /home/"usuario"
#move a pasta do executavel para pasta de software
#cria um .sh no /bin com nome do executavel
#Cria um icone no app no menu
#obs(nome deve ser o mesmo do executavel com .png no final)

Caminho_Do_Software=/opt/

#!/bin/bash

#variaveis
opcao=()
Select=()
BEGGIN=0
END=18
count=$BEGGIN
ATUAL=$(date +"%Y-%m-%d-%H:%M:%S")
nomeDistro=$(cat /etc/*release | grep VERSION_CODENAME | sed -e 's/[^a-z]//g')

#Leitura de Entradas
cima=$'\e[A'
baixo=$'\e[B'
direita=$'\e[C'
esquerda=$'\e[D'
espaco=" "
Selected="+"

#Iniciando espaços do menu
while [[ $count -le $END ]]
do
   Select[$count]=" " 
   opcao[$count]=" " 
   count=$((count+1))
done
count=$BEGGIN
Select[$count]="->"


while [[ ${opcao[${END}]} != $Selected ]]
do
  clear
  echo -e "\n\n***Menu de softwares [utilize usuario SUDO]***"
  echo "  "${Select[0]}"["${opcao[0]}"] Atualizar lista do apt"
  echo "  "${Select[1]}"["${opcao[1]}"] Instalar utilitarios do sistema [su -]"
  echo "  "${Select[2]}"["${opcao[2]}"] Instalar ferramentas de desenvolvedor de sistema"
  echo "  "${Select[3]}"["${opcao[3]}"] Instalar Utilitarios KVM"
  echo "  "${Select[4]}"["${opcao[4]}"] Instalar utilitarios rede BRIDGED"
  echo "  "${Select[5]}"["${opcao[5]}"] Instalar ferramentas de design"
  echo "  "${Select[6]}"["${opcao[6]}"] Instalar drivers NVIDEA"
  echo "  "${Select[7]}"["${opcao[7]}"] Instalar Wake On Lan"
  echo "  "${Select[8]}"["${opcao[8]}"] Instalar area remota RDP"
  echo "  "${Select[9]}"["${opcao[9]}"] Instalar PHP/APACHE"
  echo "  "${Select[10]}"["${opcao[10]}"] Instalar OPENJDK"
  echo "  "${Select[11]}"["${opcao[11]}"] Instalar FIREWALL"
  echo "  "${Select[12]}"["${opcao[12]}"] Instalar navegador Opera"
  echo "  "${Select[13]}"["${opcao[13]}"] Instalar FlameShot [Captura de Tela][FLATPAK]"
  echo "  "${Select[14]}"["${opcao[14]}"] Instalar chave SSH"
  echo "  "${Select[15]}"["${opcao[15]}"] Instalar I3WM [GERENCIADOR DE JANELAS]"
  echo "  "${Select[16]}"["${opcao[16]}"] LIVREEEEEEE"
  echo "  "${Select[17]}"["${opcao[17]}"] Instalar VIM com plugins"
  echo -e "  "${Select[${END}]}"["${opcao[${END}]}"] CONFIRM\n"

   
  read -n{0,1,2,3} -d' ' -s arrow
   
  case $arrow in
      $cima)
        Select[$count]=" "
        count=$((count-1))
        case $count in
           $((BEGGIN-1)))
              count=$END
           ;;
           *);;
        esac
        Select[$count]="->"
      ;;

     $baixo)
        Select[$count]=" "
        count=$((count+1))
        case $count in
           $((END+1)))
              count=$BEGGIN
           ;;
           *);;
        esac
        Select[$count]="->"
     ;;
     
     *)
        if [[ -z $arrow ]] #valida se é nulla
        then
           if   [[ ${opcao[$count]} == $espaco ]]
           then
              opcao[$count]=$Selected
           else
              opcao[$count]=$espaco
           fi
        fi
     ;;
  esac
 
done



















echo "***INICIANDO O INSTALADOR***"

if [ -d ${Caminho_Do_Software} ];
	then 
		echo "Ficheiro software ja existe!!!"
	else 
		mkdir $Caminho_Do_Software
		echo "Criado com Sucesso o Ficheio software!"
fi

echo "Digite o caminho do Executavel:"
read pasta
echo "Digite o nome do executavel:"
read executavel
echo "Digite o nome da capa:"
read foto

if [ -d ${pasta} ];
	then 
		mv ${pasta} ${Caminho_Do_Software}
		echo "${pasta} enviado com Sucesso para Sofware"
	else 
		echo "Não existe pasta FIM!!!"
		break
fi
chmod +x ${Caminho_Do_Software}/${pasta}/${executavel}

touch ${executavel}
echo "#!/bin/bash" 			   > ${executavel}
echo "cd ${Caminho_Do_Software}/${pasta}/" >> ${executavel}
echo "./${executavel}" 			  >> ${executavel}
chmod +x ${executavel}

touch ${executavel}.desktop
echo "[Desktop Entry]" 			   		       > ${executavel}.desktop
echo "Type=Application" 		  		      >> ${executavel}.desktop
echo "Name=${executavel}" 		  		      >> ${executavel}.desktop
echo "Keywords=ide;editor;${executavel};" 		      >> ${executavel}.desktop
echo "Comment=${executavel}" 		  		      >> ${executavel}.desktop
echo "Exec=${Caminho_Do_Software}/${pasta}/${executavel}"     >> ${executavel}.desktop
echo "Icon=${Caminho_Do_Software}/${pasta}/${foto}" >> ${executavel}.desktop
echo "Terminal=false" 					      >> ${executavel}.desktop

sudo mv ${executavel}	      /bin/
sudo mv ${executavel}.desktop /usr/share/applications/
echo "Instalação Concluida Com sucesso!!!"
