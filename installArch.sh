#Instalar wget antes

pacman -Syu xorg xorg-server grub sddm networkmanager os_prober
systemctl enable sddm
systemctl enable NetworkManager
pacman -Syu plasma-desktop kde-applications iptables pulseaudio lxc nano

echo ****riando usuario****
useradd -m geovane
echo "geovane ALL=(ALL:ALL) ALL" >> /etc/sudoers

pacman -Syu tar curl zip unzip git net-tools openssh sudo gcc gdb
pacman -Syu gparted libreoffice code thunderbird flameshot virtualbox


#OS: Arch Linux
#
#DE: KDE Plasma
#
#WM: KWin
#
#WM Theme: Arc-OSX-Black-Transparent
#
#Icons: Papirus-Dark
#
#Dock: latte-dock
#
#Terminal: Konsole
#
#Wallpaper: Mountain
