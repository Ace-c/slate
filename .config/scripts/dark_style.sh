#!/bin/bash

KDE_CONF="$HOME/.config/kdeglobals"
KV_CONF="$HOME/.config/Kvantum/kvantum.kvconfig"

# colorscheme files in ~/.local/share/color-schemes/)
DARK_COLOR="WhiteSurDark"
LIGHT_COLOR="WhiteSur"  

DARK_KVANTUM="WhiteSurDark"
LIGHT_KVANTUM="WhiteSur"

apply_dark() {
    echo "Applying GTK Dark Theme..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark-solid"
    gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark'

    echo "Applying qt Dark scheme..."
    sed -i "s/^ColorScheme=.*/ColorScheme=$DARK_COLOR/" "$KDE_CONF"
    sed -i "s/^Name=.*/Name=$DARK_COLOR/" "$KDE_CONF"
    sed -i "s/^theme=.*/theme=$DARK_KVANTUM/" "$KV_CONF"
}

apply_light() {
    echo "Applying GTK Light Theme..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Light-solid"
    gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light'

    echo "Applying qt Light Scheme..."
    sed -i "s/^ColorScheme=.*/ColorScheme=$LIGHT_COLOR/" "$KDE_CONF"
    sed -i "s/^Name=.*/Name=$LIGHT_COLOR/" "$KDE_CONF"
    sed -i "s/^theme=.*/theme=$LIGHT_KVANTUM/" "$KV_CONF"
}


case "$1" in
    -d|--dark)
        apply_dark
        ;;
    -l|--light)
        apply_light
        ;;
    *)
        echo "Usage: ./dark_syle.sh [-d (dark) | -l (light)]"
        exit 1
        ;;
esac

echo "GTK will follow toogle quickly, but qt & kde apps requires restart."
