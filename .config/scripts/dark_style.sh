#!/bin/bash

KV_CONF="$HOME/.config/Kvantum/kvantum.kvconfig"

LIGHT_KVANTUM="AustralAzure"
DARK_KVANTUM="kvantum"



apply_light() {
    echo "Applying GTK Light Theme..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.interface gtk-theme "slate-Light-solid"
    gsettings set org.gnome.shell.extensions.user-theme name 'Marble-blue-light'

    echo "Applying qt Light Theme..."
    sed -i "s/^theme=.*/theme=$LIGHT_KVANTUM/" "$KV_CONF"
    
    gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/wallpapers/a_close_up_of_leaves.jpg"
}


apply_dark() {
    echo "Applying GTK Dark Theme..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme "slate-Dark-solid"
    gsettings set org.gnome.shell.extensions.user-theme name 'Marble-blue-dark'

    echo "Applying qt Dark Theme..."
    sed -i "s/^theme=.*/theme=$DARK_KVANTUM/" "$KV_CONF"
    
    gsettings set org.gnome.desktop.background picture-uri-dark "$HOME/Pictures/wallpapers/Everblush_Mike_erskine.jpg"
}



case "$1" in
    -l|--light)
        apply_light
        ;;
    -d|--dark)
        apply_dark
        ;;
    *)
        echo "Usage: ./dark_syle.sh [-d (dark) | -l (light)]"
        exit 1
        ;;
esac

echo "GTK will follow toogle quickly, but qt-based apps requires restart."
