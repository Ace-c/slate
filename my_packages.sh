#!/bin/bash

sudo apt update
essential_packages=(
    "build-essential" #meta-package that installs everything you need to compile software from source
    "git"  #kaun nahi janta issee
    "wget"  #Better for simple file downloads and recursive "web-scraping."
    "curl"  #generally more powerful for data transfer
    "htop"  #monitoring in real time
    "dstat"   #Tool that combines the power of vmstat, iostat, and ifstat
    "ripgrep" #incredibly fast replacement for grep
    "sed"  #used to perform basic text transformations
    "gawk"  #designed for processing and analyzing text files that are structured in rows and columns
    "fd-find"  #faster and more intuitive alternative to the traditional find command
    "fzf"  #fuzzy finder
    "neovim"  #kaun nahi janta isse
    "tmux"   #terminal multiplexer
    "lnav"   #Log-file navigator
    "net-tools"   #collection of legacy networking utilities like ifconfig, route, and netstat
    "ufw"   #managing complex firewall rules, making it easy to block or allow specific traffic.
    "fail2ban"   #It watches your logs for repeated failed login attempts and automatically bans the offending IP addresses using the firewall
    "iftop"  # Monitors network bandwidth. It shows you exactly which IP addresses are using the most data on your network interface.
    "nmap"  #used for security auditing and discovering what devices and ports are active on a network.
    "tcpdump"   #packet sniffer, It lets you capture and inspect the actual data packets traveling over your network
    "traceroute"   #diagnostic tool that shows the "path" a packet takes across the internet to reach a destination, helping you find where a connection is failing
    "openssh-server" #SSH
    "rsync"  #copying and synchronizing files between folders or different servers
    "firejail"   #kamre mai bnd krke rakhta hai, sans leke ke liye bs ek ched khula rakhta hai
    "gnupg"   #used for encrypting and signing data
    "rkhunter"  #It scans your system for hidden malware, backdoors and rootkits
    "lynis"  #It scans your entire system and provides a "Hardening Index" score along with specific tips
)

for package in "${essential_packages[@]}"; do
    sudo apt install -y "$package"
done
echo "essentials installed"

# Only essentials
echo "Want to proceed?"
read -p "continue? (y/n): " proceed

if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
    echo "bye bye ... !"
    exit 0
fi


# My packages list
my_packages=(
    "blackbox-terminal"
    "fastfetch"
    "krita"
    "inkscape"
    "okular"
    "shotcut"
    "qbittorrent"
    "pcmanfm-qt"
    "qalculate-gtk"
    "texstudio"
)

for package in "${my_packages[@]}"; do
    sudo apt install -y "$package" 
done
echo "my package installed!"



# Installing flatpak apps
sudo apt install flatpak -y
flatpak remote-add -y --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Installing flatpak apps..."
flatpak_apps=(
    "com.github.neithern.g4music"     
    "org.zulip.Zulip"           
    "org.onlyoffice.desktopeditors"
    "com.notesnook.Notesnook"
    "io.github.flattool.Warehouse"
    "org.localsend.localsend_app"
    "io.github.aandrew_me.ytdn"
    "org.gnome.Showtime"
    "net.nokyan.Resources"
    "com.github.PintaProject.Pinta"
)

for app in "${flatpak_apps[@]}"; do
    echo "Installing $app..."
    flatpak install -y flathub "$app" || echo "Failed to install $app"
done

echo "Installation complete!"


# Manual installation of packages
## Vivaldi-Broswer
if dpkg -s vivaldi-stable &>/dev/null;then
    echo "Vivaldi is already installed! skipping..."
else
curl -fsSL https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/vivaldi.gpg
cat <<EOF | sudo tee /etc/apt/sources.list.d/vivaldi.sources
Types: deb
URIs: https://repo.vivaldi.com/stable/deb/
Suites: stable
Components: main
Architectures: amd64 arm64 armhf
Signed-By: /usr/share/keyrings/vivaldi.gpg
EOF
sudo rm -f /etc/apt/sources.list.d/vivaldi.list
sudo apt update
sudo apt install vivaldi-stable -y
fi

## Mega-sync
echo "Installing mega-sync package..."
wget https://mega.nz/linux/repo/Debian_13/amd64/megasync-Debian_13_amd64.deb && sudo apt install "$PWD/megasync-Debian_13_amd64.deb"
sudo apt install -f -y
rm -f megasync-Debian_13_amd64.deb
echo "Megasync installed"

wget https://mega.nz/linux/repo/Debian_13/amd64/nautilus-megasync-Debian_13_amd64.deb && sudo apt install "$PWD/nautilus-megasync-Debian_13_amd64.deb"
sudo apt install -f -y
rm -f nautilus-megasync-Debian_13_amd64.deb
echo "Megasync nautilus integration added"

## Google Antigravity 
echo "Installing Google-Antigravity IDE..."
if dpkg -s antigravity &>/dev/null; then
  echo "Antigravity already installed — skipping"
else
[ -d /etc/apt/keyrings ] || sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  sudo gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  sudo tee /etc/apt/sources.list.d/antigravity.list > /dev/null

sudo apt update
sudo apt install antigravity -y
echo "Google Antigravity Installed"
fi 

## Cursor IDE
echo "Installing Cursor IDE..."
if dpkg -s cursor &>/dev/null; then
  echo "Cursor already installed — skipping"
else
curl -fsSL https://downloads.cursor.com/keys/anysphere.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/cursor.gpg > /dev/null
echo "deb [arch=amd64,arm64 signed-by=/etc/apt/keyrings/cursor.gpg] https://downloads.cursor.com/aptrepo stable main" | sudo tee /etc/apt/sources.list.d/cursor.list > /dev/null
sudo apt update
sudo apt install cursor -y
echo "Cursor IDE Installed"
fi

## Free Download Manager
echo "Installing freedownloadmanager"
wget https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb && sudo apt install "$PWD/freedownloadmanager.deb"
sudo apt install -f -y
rm -f freedownloadmanager.deb
echo " FDM installed"

## Obsidian
echo "Installing obsidian..."
DEB_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*_amd64.deb" | cut -d '"' -f 4)

if [ -n "$DEB_URL" ]; then
    echo "Latest version found: $(basename "$DEB_URL")"
    
    echo "Downloading..."
    wget -q --show-progress -O /tmp/obsidian.deb "$DEB_URL"
    
    echo "Installing..."
    sudo apt install /tmp/obsidian.deb -y
  
    rm /tmp/obsidian.deb
    sudo apt install -f -y
    echo "Obsidian installed successfully!"
else
    echo "Error: Could not find the download URL"
fi

## Opencomic 
echo "Installing opencomic reader..."
OPENCOMIC_URL=$(curl -s https://api.github.com/repos/ollm/OpenComic/releases/latest | grep "browser_download_url.*_amd64.deb" | cut -d '"' -f 4)

if [ -n "$OPENCOMIC_URL" ]; then
    echo "Latest version found: $(basename "$OPENCOMIC_URL")"
    
    echo "Downloading..."
    wget -q --show-progress -O /tmp/opencomic.deb "$OPENCOMIC_URL"
    
    echo "Installing..."
    sudo apt install /tmp/opencomic.deb -y
    
    rm /tmp/opencomic.deb
    sudo apt install -f -y
    echo "OpenComic installed successfully!"
else
    echo "Error: Could not find the OpenComic download URL."
fi

## Cryptomator
echo "Installing cryptomator..."
if dpkg -s cryptomator &>/dev/null; then
    echo "Cryptomator already installed - skipping"
else
VER=$(curl -s https://api.github.com/repos/cryptomator/cryptomator/releases/latest | grep -oP '"tag_name": "\K[^"]+')
wget "https://github.com/cryptomator/cryptomator/releases/download/$VER/cryptomator_${VER}-0ppa1_amd64.deb"
sudo dpkg -i "cryptomator_${VER}-0ppa1_amd64.deb"
sudo apt install -f -y #fix broken
rm -f "cryptomator_${VER}-0ppa1_amd64.deb"
echo "Cryptomator installed"
fi 

## Github-Desktop
echo "Installing github-desktop..."
wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'
sudo apt update && sudo apt install github-desktop -y


echo "Required Packages Installed!"
