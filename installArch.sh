#Instalar wget antes

pacman -Syu xorg xorg-server grub sddm networkmanager os_prober sudo
systemctl enable sddm
systemctl enable NetworkManager

##executar grub install
#tirar linha GRUB_DISABLE_OS_PROBER=false
#Mountar todos os discos do windows
#executar grub-mkconfig

echo ****Criando usuario****
useradd -m geovane
echo "geovane ALL=(ALL:ALL) ALL" >> /etc/sudoers

pacman -Syu plasma-desktop kde-applications iptables pulseaudio lxc nano
pacman -Syu tar curl zip unzip git net-tools openssh sudo gcc gdb
pacman -Syu gparted libreoffice code thunderbird flameshot virtualbox chromium

#INSTALL YAOURT
sudo pacman -S --needed base-devel git wget yajl
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si && cd /tmp/
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si

##install NVM
