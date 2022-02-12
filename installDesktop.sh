#!/bin/bash

#variaveis
opcao=()
Select=()
BEGGIN=0
END=13
count=$BEGGIN

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


while [[ ${opcao[12]} != $Selected ]]
do
  clear
  
  echo " ****** Menu de softwares ******"
  echo "  "${Select[0]}"["${opcao[0]}"] Atualizar lista do apt"
  echo "  "${Select[1]}"["${opcao[1]}"] Instalar ferramentas padrao de sistema"
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
  echo "  "${Select[12]}"["${opcao[12]}"] CONFIRM"
  echo ""
   
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
      cp /etc/apt/sources.list /etc/apt/sources.list.bkp
      nomeDistro=$(cat /etc/*release | grep VERSION_CODENAME | sed -e 's/[^a-z]//g')
      echo "deb http://deb.debian.org/debian "$nomeDistro" main contrib non-free" > /etc/apt/sources.list
      echo "deb-src http://deb.debian.org/debian "$nomeDistro" bullseye main contrib non-free" >> /etc/apt/sources.list
      echo "deb http://security.debian.org/debian-security/ "$nomeDistro"-security main contrib non-free" >> /etc/apt/sources.list
      echo "deb-src http://security.debian.org/debian-security/ "$nomeDistro"-security "$nomeDistro"-security main contrib non-free" >> /etc/apt/sources.list
      echo "deb http://deb.debian.org/debian "$nomeDistro"-updates main contrib non-free" >> /etc/apt/sources.list
      echo "deb-src http://deb.debian.org/debian "$nomeDistro"-updates main contrib non-free" >> /etc/apt/sources.list
      apt update
fi

if [[ ${opcao[1]} == $Selected ]] 
   then 
      apt install -y tilix neofetch tar curl zip unzip get net-tools ssh
fi

if [[ ${opcao[2]} == $Selected ]] 
   then 
      apt install -y git gcc gdb gparted build-essential thunderbird
fi

if [[ ${opcao[3]} == $Selected ]] 
   then 
      apt install -y qemu-system libvirt-clients libvirt-daemon-system virt-manager
fi
 
if [[ ${opcao[4]} == $Selected ]] 
   then 
      apt install -y dnsmasq-base bridge-utils
fi

if [[ ${opcao[5]} == $Selected ]] 
   then 
      apt install -y inkscape gimp
fi

if [[ ${opcao[6]} == $Selected ]] 
   then 
      apt install linux-headers-amd64 nvidia-detect -y
      apt install nvidia-driver linux-image-amd64 -y
fi

if [[ ${opcao[7]} == $Selected ]] 
   then 
      apt install -y ethtool wakeonlan
      #Colocar ethernet-wol g dentro de interfaces
fi

if [[ ${opcao[8]} == $Selected ]] 
   then 
      apt install -y remmina #and openVPN3
fi

if [[ ${opcao[9]} == $Selected ]] 
   then 
      apt install -y php apache2
fi
  
if [[ ${opcao[10]} == $Selected ]] 
   then 
      apt install -y default-jdk
fi

if [[ ${opcao[9]} == $Selected ]] 
   then 
      apt install iptables
fi
echo "*******************************"
echo "                               "
echo "****** FIM DA INSTALACAO ******"
echo "                               "
echo "*******************************"
