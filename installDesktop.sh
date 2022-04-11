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

if [[ ${opcao[0]} == $Selected ]] 
   then  
      sudo cp /etc/apt/sources.list /etc/apt/sources.list${ATUAL}
      sudo echo "deb http://deb.debian.org/debian "$nomeDistro" main contrib non-free" > /etc/apt/sources.list
      sudo echo "deb-src http://deb.debian.org/debian "$nomeDistro" main contrib non-free" >> /etc/apt/sources.list
      sudo echo "deb http://security.debian.org/debian-security/ "$nomeDistro"-security main contrib non-free" >> /etc/apt/sources.list
      sudo echo "deb-src http://security.debian.org/debian-security/ "$nomeDistro"-security main contrib non-free" >> /etc/apt/sources.list
      sudo echo "deb http://deb.debian.org/debian "$nomeDistro"-updates main contrib non-free" >> /etc/apt/sources.list
      sudo echo "deb-src http://deb.debian.org/debian "$nomeDistro"-updates main contrib non-free" >> /etc/apt/sources.list
      sudo apt update
fi

if [[ ${opcao[1]} == $Selected ]] 
   then 
      apt install -y tilix tar curl zip unzip wget net-tools ssh sudo
      read -p "Insira o nome do usuario para SUDO:" USUARIO
      adduser ${USUARIO} sudo
      echo -e "\n***********SISTEMA SERÁ REINICIADO**************\n"
      systemctl reboot
fi

if [[ ${opcao[2]} == $Selected ]] 
   then 
      sudo apt install -y git gcc gdb build-essential
fi

if [[ ${opcao[3]} == $Selected ]] 
   then 
      sudo apt install -y qemu-system libvirt-clients libvirt-daemon-system virt-manager
fi
 
if [[ ${opcao[4]} == $Selected ]] 
   then 
      sudo apt install -y dnsmasq-base bridge-utils
fi

if [[ ${opcao[5]} == $Selected ]] 
   then 
      sudo apt install -y inkscape gimp
fi

if [[ ${opcao[6]} == $Selected ]] 
   then 
      sudo apt install linux-headers-amd64 nvidia-detect -y
      sudo apt install nvidia-driver linux-image-amd64 -y
fi

if [[ ${opcao[7]} == $Selected ]] 
   then 
      sudo apt install -y ethtool wakeonlan
      sudo cp /etc/network/interfaces /etc/network/interfaces${ATUAL}
      sudo echo -e "\nethernet-wol g" >> /etc/network/interfaces
fi

if [[ ${opcao[8]} == $Selected ]] 
   then 
      sudo apt install apt-transport-https
      sudo curl -fsSL https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub | gpg --dearmor > /etc/apt/trusted.gpg.d/openvpn-repo-pkg-keyring.gpg
      sudo curl -fsSL https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-${nomeDistro}.list >/etc/apt/sources.list.d/openvpn3.list
      sudo apt update
      sudo apt install -y remmina openvpn3
fi

if [[ ${opcao[9]} == $Selected ]] 
   then 
      sudo apt install -y php apache2
fi
  
if [[ ${opcao[10]} == $Selected ]] 
   then 
      sudo apt install -y default-jdk
fi

if [[ ${opcao[11]} == $Selected ]] 
   then 
      sudo apt install iptables -y
fi

if [[ ${opcao[12]} == $Selected ]] 
   then
      sudo wget -O - https://deb.opera.com/archive.key | apt-key add -
      sudo echo -e "\ndeb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list
      sudo apt update
      sudo apt install opera-stable -y 
fi

if [[ ${opcao[13]} == $Selected ]] 
   then 
      sudo apt install flatpak -y
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install flathub org.flameshot.Flameshot -y

	  echo -e "\nINFORME O USUARIO:"
	  read user1
	  if [[ -e "/home/${user1}/.config/i3/config" ]]; then
		if [[ -z $(cat /home/${user1}/.config/i3/config |grep Print) ]]; then
	    	echo -e "\n#====================FLAMESHOT [atalho]=======================" >> /home/${user1}/.config/i3/config
	    	echo -e "\nbindsym Print exec \"flatpak run org.flameshot.Flameshot gui\"" >> /home/${user1}/.config/i3/config
        	echo -e "\n#=============================================================\n" >> /home/${user1}/.config/i3/config
		else
		   	echo -e "\n\nJÁ ESTA UTILIZADO A TECLA PRINT [atalho]\n\n"
	  	 fi
      fi
fi

if [[ ${opcao[14]} == $Selected ]] 
   then
      echo "******************************************************"
      echo "*******INSTALAR CHAVE SSH [ENTER] e [SUA SENHA]*******"
      echo "******************************************************"
      ssh-keygen -t rsa -b 4096 -C "GeoVaNe-aLeXaNDRe-MoRaiS"
      echo -e "\n*******CHAVE PUBLICA EM [/home/${USER}/.ssh/id_rsa.pub]*******"
      echo $(cat /home/${USER}/.ssh/id_rsa.pub) 
      echo -e "**************[ENTER] PARA FINALIZAR**************\n"
      read
fi

if [[ ${opcao[15]} == $Selected ]] 
   then 
   sudo apt install -y i3 i3blocks xorg lightdm polybar feh rofi numlockx polybar wmctrl
   
   mkdir /home/${USER}/Desktop
   mkdir /home/${USER}/Downloads
   mkdir /home/${USER}/Imagens
   mkdir /home/${USER}/Videos
   mkdir /home/${USER}/github
   mkdir -p /home/${USER}/.config/polybar

   echo -e  "\n\n***Selecionei Autohinter e BITMAP na proxima tela[ENTER]***\n" 
   read teste
   sudo dpkg-reconfigure fontconfig-config
   
   sudo killall -q polybar
   #sudo polybar -c /home/${USER}/.config/polybar/config main &
   mkdir -p /home/${USER}/.config/polybar.old/
   cd polybar-themes/
   ./setup.sh
   cd ..

   sudo cp configI3 /home/${USER}/.config/i3/config
   
   sudo chmod 777 -R /home/${USER}
fi
if [[ ${opcao[16]} == $Selected ]] 
   then
      sudo apt install -y thunderbird firefox-esr libreoffice gparted calc
fi

if [[ ${opcao[17]} == $Selected ]]
   then 
   sudo apt install vim curl -y 
   cp /home/${USER}/.vimrc /home/${USER}/.vimrc${ATUAL}
   
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   
   if [[ ! -d /home/${USER}/.vim/plugged ]]
   then
       mkdir /home/${USER}/.vim/plugged
   fi
   
   cp .vimrc /home/${USER}/.vimrc
   
   sudo chmod 777 -R /home/${USER}
   
   echo "***************************************************"
   echo "                                                   "
   echo "***********PLUGINS LISTADOS COM SUCESSO************"
   echo "                                                   "
   echo "***************************************************"
fi
   

echo "***************************************************"
echo "                                                   "
echo "**************** FIM DA INSTALACAO ****************"
echo "                                                   "
echo "***************************************************"
