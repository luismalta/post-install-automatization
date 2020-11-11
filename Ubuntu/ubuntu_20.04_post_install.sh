#!/usr/bin/env bash
# ----------------------------- SETUP VARIABLES ----------------------------- #
DOWNLOAD_FOLDER="$HOME/Downloads/postinstall"

BASIC_FOLDERS=(
    🌀 Softwares
    🔥 Projects
    .icons
    .themes
    .wallpapers
)

APT_SOFTWARES=(
  snapd
  gnome-tweaks
  git
  steam-installer
)

DEB_SOFTWARES=(
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
)

SNAP_SOFTWARES=(
    spotify
    discord
    pycharm-professional
    code
)

PPA_LIST=(

)

# ---------------------------------------------------------------------- #

# ----------------------------- INSTALLATION ----------------------------- #

sudo apt update -y

# Installing deb softwares #
echo "Downloading .deb softwares"
mkdir "$DOWNLOAD_FOLDER"
for software in ${DEB_SOFTWARES[@]}; do
    wget -c "$software" -P "$DOWNLOAD_FOLDER"
done

sudo dpkg -i $DOWNLOAD_FOLDER/*.deb

# Installing apt softwares #
echo "Downloading apt softwares"
for software in ${APT_SOFTWARES[@]}; do
  if ! dpkg -l | grep -q $software; then
    apt install "$software" -y
  else
    echo "[Already installed] - $software"
  fi
done

# Installing snap softwares ##
echo "Downloading snap softwares"
for software in ${SNAP_SOFTWARES[@]}; do
    sudo snap "$software"
done

# ---------------------------------------------------------------------- #

# ----------------------------- SETUP ENVIRONMENT ------------------------------- #

echo "Setup git variables"
git config --global user.name $0
git config --global user.email $1

echo "Creating basic folders"
for folder in ${BASIC_FOLDERS[@]}; do
    mkdir $HOME/"$folder"
done

# ----------------------------- POST INSTALLATION----------------------------- #
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #