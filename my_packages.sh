#!/bin/bash

sudo apt update
essential_packages=(
    "build-essential" #meta-package that installs everything you need to compile software from source
    "meson" #Meson and Ninja are used together as a modern, high-speed software build automation toolset
    "ninja-build" #run compiler commands in parallel based on the exact instructions Meson gives it
    "git"  #free and open-source tool for tracking changes in computer files
    "wget"  #Better for simple file downloads and recursive "web-scraping."
    "curl"  #generally more powerful for data transfer
    "glances" #real-time overview of your Linux system metrics in a single compact dashboard
    "dstat"   #Tool that combines the power of vmstat, iostat, and ifstat
    "ripgrep" #incredibly fast replacement for grep
    "sed"  #used to perform basic text transformations
    "gawk"  #designed for processing and analyzing text files that are structured in rows and columns
    "fd-find"  #faster and more intuitive alternative to the traditional find command
    "fzf"  #fuzzy finder
    "neovim"  #Open source text editor, an fork of vim
    "openssh-server" #open-source connectivity tool for remote login, using ssh
    "rsync"  #copying and synchronizing files between folders or different servers
    "lnav"   #Log-file navigator
    "net-tools"   #collection of legacy networking utilities like ifconfig, route, and netstat
    "ufw"   #managing complex firewall rules, making it easy to block or allow specific traffic.
    "fail2ban"   #It watches your logs for repeated failed login attempts and automatically bans the offending IP addresses using the firewall
    "iftop"  # Monitors network bandwidth. It shows you exactly which IP addresses are using the most data on your network interface.
    "nmap"  #used for security auditing and discovering what devices and ports are active on a network.
    "tcpdump"   #packet sniffer, It lets you capture and inspect the actual data packets traveling over your network
    "traceroute"   #diagnostic tool that shows the "path" a packet takes across the internet to reach a destination, helping you find where a connection is failing
    "firejail"   #sandbox program for Linux that enhances security by isolating applications in their own restricted environments
    "gnupg"   #used for encrypting and signing data
    "rkhunter"  #It scans your system for hidden malware, backdoors and rootkits
    "lynis"  #It scans your entire system and provides actionable recommendations to improve security defenses
    "inxi"   #It provides summary of your system hardware, drivers, kernel, and system-level data
    "strace"  #It captures system calls, signal deliveries, and process state changes, crashes, tracing performance bottlenecks, and troubleshooting permissions
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


# My packages (Repo + Manual)
my_packages=(
    "blackbox-terminal"
    "fastfetch"
    "okular"
    "qalculate-gtk"
    "mpv"
)

for package in "${my_packages[@]}"; do
    sudo apt install -y "$package" 
done
echo "my package installed!"

# Importing configuration for my_packages :
echo "importing blackbox-terminal configuration:)"
if [ -f ".config/blackbox-settings.txt" ]; then dconf load /com/raggesilver/BlackBox/ < .config/blackbox-settings.txt; fi

echo "importing fastfetch configuration:)"
if [ -f ".config/fastfetch/config.jsonc" ]; then cp -r .config/fastfetch ~/.config/; fi

echo "importing okular config"
cp .config/okularrc .config/okularpartrc ~/.config/



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


## Mega-sync(debian 13)
wget https://mega.nz/linux/repo/Debian_13/amd64/megasync-Debian_13_amd64.deb && sudo apt install "$PWD/megasync-Debian_13_amd64.deb"
sudo apt install -f -y
rm -f megasync-Debian_13_amd64.deb
wget https://mega.nz/linux/repo/Debian_13/amd64/nautilus-megasync-Debian_13_amd64.deb && sudo apt install "$PWD/nautilus-megasync-Debian_13_amd64.deb"
rm -f nautilus-megasync-Debian_13_amd64.deb
echo "Megasync installed"


## Anytype
echo "Installing anytype desktop"
VER=$(curl -s https://api.github.com/repos/anyproto/anytype-ts/releases/latest | grep -oP '"tag_name": "v\K[^"]+')
wget "https://github.com/anyproto/anytype-ts/releases/download/v${VER}/anytype_${VER}_amd64.deb"
sudo dpkg -i "anytype_${VER}_amd64.deb"
sudo apt install -f -y
rm -f "anytype_${VER}_amd64.deb"
echo "Anytype installed"


## Obsidian
echo "Installing obsidian..."
DEB_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*_amd64.deb" | cut -d '"' -f 4)
wget -q --show-progress -O /tmp/obsidian.deb "$DEB_URL"
sudo apt install /tmp/obsidian.deb -y
rm /tmp/obsidian.deb
sudo apt install -f -y
echo "Obsidian installed successfully!"


## Free Download Manager
echo "Installing freedownloadmanager"
wget https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb && sudo apt install "$PWD/freedownloadmanager.deb"
sudo apt install -f -y
rm -f freedownloadmanager.deb
echo " FDM installed"


## Opencomic 
echo "Installing opencomic reader..."
OPENCOMIC_URL=$(curl -s https://api.github.com/repos/ollm/OpenComic/releases/latest | grep "browser_download_url.*_amd64.deb" | cut -d '"' -f 4)
wget -q --show-progress -O /tmp/opencomic.deb "$OPENCOMIC_URL"
sudo apt install /tmp/opencomic.deb -y
rm /tmp/opencomic.deb
sudo apt install -f -y
echo "OpenComic installed successfully!"


## Github-Desktop
echo "Installing github-desktop..."
wget -qO - https://mirror.mwt.me/shiftkey-desktop/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/mwt-desktop.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/mwt-desktop.gpg] https://mirror.mwt.me/shiftkey-desktop/deb/ any main" > /etc/apt/sources.list.d/mwt-desktop.list'
sudo apt update && sudo apt install github-desktop -y


## Cryptomator
echo "Installing cryptomator..."
if dpkg -s cryptomator &>/dev/null || [ -f "$HOME/.local/bin/cryptomator.AppImage" ]; then
    echo "Cryptomator already installed - skipping"
else
  
    VER=$(curl -s https://api.github.com/repos/cryptomator/cryptomator/releases/latest | grep -oP '"tag_name": "\K[^"]+')
    mkdir -p "$HOME/.local/bin"
    wget -O "$HOME/.local/bin/cryptomator.AppImage" "https://github.com/cryptomator/cryptomator/releases/download/$VER/cryptomator-${VER}-x86_64.AppImage"
    chmod +x "$HOME/.local/bin/cryptomator.AppImage"
    mkdir -p "$HOME/.local/share/applications"
    cat <<EOF > "$HOME/.local/share/applications/cryptomator.desktop"
[Desktop Entry]
Type=Application
Name=Cryptomator
Comment=Free client-side encryption for your cloud files
Exec=$HOME/.local/bin/cryptomator.AppImage
Icon=cryptomator
Terminal=false
Categories=Utility;Security;Settings;
StartupNotify=true
EOF

    # update app.desktop database
    update-desktop-database "$HOME/.local/share/applications/"
fi


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

echo "All Packages Installed!"


echo "Flatpak Packages : Install it manually ... pls"
echo "- zen browser"
echo "- mission-center"
echo "- gapless"
echo "- showtime"
