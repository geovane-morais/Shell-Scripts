#!/bin/bash

len=0
for item in $(tree -f); do
    if ! [[  "${item}" =~ "├" || "${item}" =~ "─" || "${item}" =~ "│" || "${item}" =~ "└─" ]];then
	exibir[len]=${item}
	len=$((len=len+1))
    fi
done
#DEBUG for ((x=1; x<$((len-4)); x++)); do echo ${exibir[x]}; done;

#variaveis do menu
opcao=()
Select=()
BEGGIN=1
END=$((len-4))
count=$BEGGIN

#Leitura de Entradas no READ do Menu
cima=$'\e[A'
baixo=$'\e[B'
espaco=" "
Selected="+"

#Aquivos selecionaveis
option[0]="FOTO"
option[1]="EXECUTAVEL"
pathToInstall="/opt"

for ((y=0; y<${#option[@]}; y++)); do
	#Iniciando espaços do menu
	while [[ $count -le $END ]]
	do
	   Select[$count]=" " 
	   opcao[$count]=" " 
	   count=$((count+1))
	done
	count=$BEGGIN
	Select[$count]="->"
	
	#Render menu
	while [[ ${opcao[${END}]} != $Selected ]]
	do
	  clear
	  echo -e "\n\n*** Selecione o ${option[y]} ***"
	  for ((x=$BEGGIN; x<$(($END)); x++)); do 
	  	echo "  "${Select[x]}"["${opcao[x]}"] ${exibir[x]}"
	  done
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
	
	for ((x=$BEGGIN; x<$(($END)); x++)); do 
		if [[ ${opcao[x]} == $Selected  ]];then
			if [[ ${option[y]} == "EXECUTAVEL" ]];then
				pasta=$(echo $(pwd) | cut -d'/' -f$(($(pwd | grep -o / | wc -l)+1)))
				soft=$(echo ${exibir[x]} | cut -d'/' -f2)
				echo "Pasta: ${pasta}"
				if [[ ! -d $pathToInstall/$pasta ]];then
				    sudo mkdir ${pathToInstall}/${pasta}
				fi
				echo "Teste1"
			        sudo cp ./* ${pathToInstall}/${pasta}/
			        echo "Teste2"
			        
				touch ${soft}.desktop
				echo "[Desktop Entry]" 			   		   > ${soft}.desktop
				echo "Type=Application" 		  		  >> ${soft}.desktop
				echo "Name=${soft}" 		  		          >> ${soft}.desktop
				echo "Keywords=${soft};"   		                  >> ${soft}.desktop
				echo "Comment=${soft}" 		  		          >> ${soft}.desktop
				echo "Exec=${pathToInstall}/${pasta}/${exibir[x]}"        >> ${soft}.desktop
				echo "Icon=${pathToInstall}/${pasta}/${foto}"             >> ${soft}.desktop
				echo "Terminal=false" 					  >> ${soft}.desktop
				
				echo "Teste3"
				sudo mv ${soft}.desktop /usr/share/applications/
				echo "Instalação Concluida Com sucesso!!!"
			elif [[ ${option[y]} == "FOTO" ]];then
				foto=$(echo ${exibir[x]} | cut -d'/' -f2)
			fi
		fi
	done
done
