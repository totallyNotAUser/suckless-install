#!/bin/sh

echo '[***]        dwm-st-dmenu by totallyNotAUser        [***]'
echo '[***] Hassle-free installation of suckless programs [***]'

install_deps_ubuntu() {
  sudo apt install xorg-dev build-essential
}

install_deps_arch() {
  sudo pacman -S base-devel git xorg xorg-xinit
}

arch_specific_dwm_patches() {
  # TODO
  echo todo > /dev/null
}

apply_dwm_patches() {
  case "$DISTRO" in
    arch) arch_specific_patches;;
  esac
}

apply_st_patches() {
  # TODO
  echo todo > /dev/null
}

apply_dmenu_patches() {
  # TODO
  echo todo > /dev/null
}

which apt && DISTRO="ubuntu"
which pacman && DISTRO="arch"

case "$DISTRO" in
  ubuntu) install_deps_ubuntu;;
  arch) install_deps_arch;;
  *) echo error unknown distro $DISTRO
     exit 1;;
esac

mkdir suckless
cd suckless

##### dwm #####
echo [*] Installing dwm

echo =\> [*] Downloading source
git clone https://git.suckless.org/dwm
cd dwm

echo =\> [*] Patching source
apply_dwm_patches

echo =\> [*] Compiling source
make

echo =\> [*] Installing into system
sudo make install
mv ~/.xinitrc ~/.xinitrc.old
echo "exec dwm" > ~/.xinitrc
sudo sh -c '
cat > /usr/share/xsessions/dwm.desktop << EOF
[Desktop Entry]
Name=dwm
Comment=Dynamic window manager from suckless.org (installed by totallyNotAUsers script)
Exec=dwm
Icon=dwm
Type=XSession
EOF
'

##### st #####
echo [*] Installing st

echo =\> [*] Downloading source
cd ..
git clone https://git.suckless.org/st
cd st

echo =\> [*] Patching source
apply_st_patches

echo =\> [*] Compiling source
make

echo =\> [*] Installing into system
sudo make install

##### dmenu #####
echo [*] Installing dmenu

echo =\> [*] Downloading source
cd ..
git clone https://git.suckless.org/dmenu
cd dmenu

echo =\> [*] Patching source
apply_dmenu_patches

echo =\> [*] Compiling source
make

echo =\> [*] Installing into system
sudo make install

echo [*] Done
