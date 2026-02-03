#!/bin/bash

KDE_CONF="$HOME/.config/kdeglobals"
KV_CONF="$HOME/.config/Kvantum/kvantum.kvconfig"

# colorscheme files in ~/.local/share/color-schemes/)
DARK_COLOR="WhiteSurDark"
LIGHT_COLOR="WhiteSur"  

DARK_KVANTUM="WhiteSurDark"
LIGHT_KVANTUM="WhiteSur"

apply_dark() {
    echo "Applying Dark Theme..." 
    sed -i "s/^ColorScheme=.*/ColorScheme=$DARK_COLOR/" "$KDE_CONF"
    sed -i "s/^Name=.*/Name=$DARK_COLOR/" "$KDE_CONF"
    sed -i "s/^theme=.*/theme=$DARK_KVANTUM/" "$KV_CONF"
}

apply_light() {
    echo "Applying Light Theme..."
    sed -i "s/^ColorScheme=.*/ColorScheme=$LIGHT_COLOR/" "$KDE_CONF"
    sed -i "s/^Name=.*/Name=$LIGHT_COLOR/" "$KDE_CONF"
    sed -i "s/^theme=.*/theme=$LIGHT_KVANTUM/" "$KV_CONF"
}

# Case Logic
case "$1" in
    -d|--dark)
        apply_dark
        ;;
    -l|--light)
        apply_light
        ;;
    *)
        echo "Usage: ./qt_switch.sh [-d (dark) | -l (light)]"
        exit 1
        ;;
esac

echo "Done. Changes will apply to newly opened apps."
