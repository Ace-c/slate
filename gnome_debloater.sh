#!/bin/bash
set -e

# These are my personal prefrences. okkkkiee...
echo "we're sending where they belongs to...."
PKGS=(
  gnome-software
  gnome-software-common
  gnome-software-plugin-flatpak
  gnome-software-plugin-snap
  gnome-disk-utility
  baobab
  gnome-characters
  gnome-tour
  gnome-contacts
  gnome-weather
  gnome-maps
  gnome-music
  gnome-clocks
  gnome-calculator
  gnome-sound-recorder
  gnome-snapshot
  gnome-logs
  gnome-system-monitor
  im-config
  epiphany-browser
  evolution
  evolution-common
  evolution-plugins
  malcontent
  malcontent-gui
  rhythmbox
  shotwell
  simple-scan
  totem
  cheese
  gedit
  eog
  eog-plugins
  yelp
  seahorse
  gnome-connections
  gnome-remote-desktop
  libreoffice*
  firefox-esr
)

sudo apt purge -y "${PKGS[@]}" 2>/dev/null || true
sudo apt autoremove -y
sudo apt autoclean
echo "Debloat complete "
