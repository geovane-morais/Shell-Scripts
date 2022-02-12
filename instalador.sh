#!/bin/bash

#Instalando software:
#cria uma pasta software na diretiva /home/"usuario"
#move a pasta do executavel para pasta de software
#cria um .sh no /bin com nome do executavel
#Cria um icone no app no menu
#obs(nome deve ser o mesmo do executavel com .png no final)

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

Caminho_Do_Software=/home/${USER}/software

if [ -d ${pasta} ];
	then 
		mv ${pasta} ${Caminho_Do_Software}/
		echo "${pasta} enviado com Sucesso para Sofware"
	else 
		echo "Não existe pasta FIM!!!"
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
echo "Icon=${Caminho_Do_Software}/${pasta}/${executavel}.png" >> ${executavel}.desktop
echo "Terminal=false" 					      >> ${executavel}.desktop

sudo mv ${executavel}	      /bin/
sudo mv ${executavel}.desktop /usr/share/applications/
echo "Instalação Concluida Com sucesso!!!"

