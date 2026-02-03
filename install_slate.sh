#!/bin/bash
set -e

# Installing prerequisites
sudo apt update
sudo apt install \
    unzip git jq curl wget \
    gnome-shell-extensions gnome-shell-extension-manager dconf-cli \
    python3-pip python3-venv \
    qt5ct qt6ct qt5-style-kvantum qt6-style-kvantum \
    conky-all zsh -y


# Installling icons
echo "Installing icons..."
[ -d ~/.icons ] || { echo "Creating ~/.icons..."; mkdir -p ~/.icons; }
cd .icons
unzip -o slate-circle.zip -d ~/.icons
unzip -o material_light_cursors.zip -d ~/.icons
gsettings set org.gnome.desktop.interface icon-theme 'slate-circle'
gsettings set org.gnome.desktop.interface cursor-theme 'material_light_cursors'
cd ..
echo "Icons installed successfully!"


# Installing fonts
echo "Installing fonts..."
[-d ~/.local/share/fonts] || mkdir -p ~/.local/share/fonts
cp -r fonts/* ~/.local/share/fonts/
fc-cache -fv
gsettings set org.gnome.desktop.interface font-name 'IBM Plex Sans 10'
echo "Fonts installed successfully!"


# Setting up extensions
echo "Installing gnome-extensions..."
## Installing helper program "gnome-extensions-cli"(https://github.com/essembeh/gnome-extensions-cli.git)
pip3 install --upgrade gnome-extensions-cli --break-system-packages || pip3 install --user --upgrade gnome-extensions-cli
export PATH="$HOME/.local/bin:$PATH"

EXTENSIONS=(
  "appindicatorsupport@rgcjonas.gmail.com"
  "caffeine@patapon.info"
  "clipboard-history@alexsaveau.dev"
  "custom-command-toggle@storageb.github.com"
  "dash-to-panel@jderose9.github.com"
  "date-menu-formatter@marcinjakubowski.github.com"
  "gsconnect@andyholmes.github.io"
  "just-perfection-desktop@just-perfection"
  "quick-settings-tweaks@qwreey"
  "user-stylesheet@tomaszgasior.pl"
  "user-theme@gnome-shell-extensions.gcampax.github.com"
  "vertical-workspaces@G-dH.github.com"
)

for UUID in "${EXTENSIONS[@]}"; do
  gnome-extensions-cli install "$UUID"
  gnome-extensions-cli enable "$UUID"
done

echo "Importing extension settings..."
sleep 3

shopt -s nullglob
DCONF_DIR=".config/dconf"

if [ -d "$DCONF_DIR" ]; then
    for file in "$DCONF_DIR"/*.conf; do
        ext_name="$(basename "$file" .conf)"
        
        echo "Restoring settings for $ext_name..."
        dconf load "/org/gnome/shell/extensions/$ext_name/" < "$file"
    done
else
    echo "No settings to import!"
fi

## Importing user-stylesheet configuration & qt_theme switch script
echo "Importing user-stylesheet for gnome-shell & theme toggle script..."
mkdir -p ~/.config/gnome-shell
cp -rf .config/gnome-shell/* ~/.config/gnome-shell/
cp -rf .config/scripts ~/.config/
chmod +x ~/.config/scripts/*.sh


# Setting up libadwaita & gtk-themes
echo "Setting up gtk & libadwaita theme..."
[ -d ~/.themes ] || mkdir -p ~/.themes
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
./install.sh -l -c light -N glassy --shell
cd ..

gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Light-solid"
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'


# Setting-up Qt themes
echo "Installing qt themes..."

mkdir -p ~/.config/Kvantum ~/.config/qt5ct ~/.config/qt6ct
mkdir -p ~/.local/share/color-schemes

cp -rf .config/Kvantum/* ~/.config/Kvantum/
cp -rf .config/qt5ct/* ~/.config/qt5ct/
cp -rf .config/qt6ct/* ~/.config/qt6ct/
cp -rf .config/color-schemes/* ~/.local/share/color-schemes/
cp -f .config/kdeglobals ~/.config/

echo "Setting system-wide Qt environment variables..."

## setting env-vars for qt
if ! grep -q "QT_QPA_PLATFORMTHEME" /etc/environment; then

    echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment
    echo 'QT_STYLE_OVERRIDE=kvantum' | sudo tee -a /etc/environment
    echo "Env vars added to /etc/environment."
else
    echo "Env vars already exist."
fi

# flatpak fix for GTK & QT themes
if command -v flatpak >/dev/null 2>&1; then
    echo "Flatpak detected! Applying GTK theme overrides..."
    flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
    flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
    flatpak override --user --filesystem=xdg-config/Kvantum:ro
    flatpak override --user --filesystem=xdg-config/kdeglobals:ro
    echo "Flatpak fix applied."
else
    echo "Flatpak not found, skipping overrides."
fi


# Set the wallpaper
echo "Setting wallpaper..."
mkdir -p "$HOME/Pictures/wallpapers"
cp -rf wallpapers/* "$HOME/Pictures/wallpapers/"

WALLPAPER_PATH_LIGHT="$HOME/Pictures/wallpapers/a_close_up_of_leaves.jpg" 
WALLPAPER_PATH_DARK="$HOME/Pictures/wallpapers/a_mountain_range_with_dark_clouds.jpg"
WALLPAPER_URI_LIGHT="file://${WALLPAPER_PATH_LIGHT}"
WALLPAPER_URI_DARK="file://${WALLPAPER_PATH_DARK}"

gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER_URI_LIGHT"
gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER_URI_DARK"
echo "Wallpaper set successfully!"


# Setting up conky
echo "Installing conky ..."
mkdir -p ~/.config/conky
cp -r .config/conky/* ~/.config/conky/

## Selecting conky themes
echo "Select conky themes you want to apply : "
echo "1. Nashira-Dark"
echo "2. Celaeno"
echo "3. Slate"

read -p "Enter your choice (1, 2, 3): " choice

case $choice in
1)
    echo "Nashira-Dark theme is selected, Applying... "
    SELECTED_CONFIG="$HOME/.config/conky/Nashira-Dark/Nashira-Dark.conf"
    ;;
2)
    echo "Celaeno theme is selected, Applying... "
    SELECTED_CONFIG="$HOME/.config/conky/Celaeno/Celaeno.conf"
    ;;
3)
    echo "Slate theme is selected, Applying... "
    SELECTED_CONFIG="$HOME/.config/conky/Slate/Slate.conf"
    ;;
*)
    echo "Invalid choice. Defaulting to Slate."
    SELECTED_CONFIG="$HOME/.config/conky/Slate/Slate.conf"
    ;;
esac
echo "conky set up successfully!"

## Setting up autostart for conky
conky -c "$SELECTED_CONFIG" &> /dev/null &

echo "Adding conky to autostart..."
mkdir -p ~/.config/autostart
cat <<EOF > ~/.config/autostart/conky.desktop
[Desktop Entry]
Type=Application
Name=Conky
Exec=sh -c "sleep 5 && conky -c $SELECTED_CONFIG -d"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Comment=Start conky at startup
EOF


# Installing powerlevel10k theme & zsh-plugins
echo "Installing powerlevel10k... "
## Change shell for the current user
echo "Changing shell to zsh for $USER..."
sudo chsh -s $(which zsh) $USER
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

echo "Configuring .zshrc theme..."
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

## Restoring powerlevel10k configuration
read -p "Do you want to import powerlevel10k conf settings? (y/n): " p10k_choice

case "$p10k_choice" in
Y|y)
    echo "Restoring custom Powerlevel10k configuration..."
    \cp -f .p10k.zsh ~/.p10k.zsh
    # Check if the source line already exists to avoid duplicates
    if ! grep -q "source ~/.p10k.zsh" ~/.zshrc; then
        echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
    fi
    echo "Configuration applied!"
    ;;
*)
    echo "Restoration cancelled."
    ;;
esac

## Installing zsh-plugins
echo "Installing zsh-plugins: Autosuggestions, Completions & Syntax-highlighting..."

git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Updating .zshrc plugin list..."
sed -i 's/plugins=(/plugins=(zsh-autosuggestions zsh-completions zsh-syntax-highlighting /' ~/.zshrc
echo "All pluings installed!"

echo "Slate Theme Installed! Please log out or restart for changes to take effect..."
