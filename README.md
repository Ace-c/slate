 # slate 

| | |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/c2c6e14b-b5c4-4d8f-9b69-eac74dcef491" width="100%"> | <img src="https://github.com/user-attachments/assets/1225fd09-7b31-4226-8200-2803fa92f919" width="100%"> |
| <img src="https://github.com/user-attachments/assets/12502a1e-13f6-425f-a9a2-4c45e54aebfe" width="100%"> | <img src="https://github.com/user-attachments/assets/645ad3e1-9fe1-40d4-a9c6-d3f3c05d2f4c" width="100%"> |


&nbsp;
## Installation :
> [!NOTE]
>**Tested on Debian 13 (stable) with GNOME 48**

```
git clone https://github.com/Ace-c/slate.git && cd slate
```
```
chmod +x ./install_slate.sh && ./install_slate.sh
```

## Features :
- Unified WhiteSur theme implementation across Libadwaita, GTK, Kvantum & Kde apps
- Unified GTK & QT theme toggle button in quick settings
- Custom Icon Pack: slate circle
- Customizable Quick-settings panel
- Clean Conky themes
- Beautiful wallpapers
- Beautiful powerlevel10k theme with zsh plugins (optional)

## Tweaks :
* GTK & Libadwaita - [WhiteSur](https://github.com/vinceliuice/WhiteSur-gtk-theme)
* Qt(kvantum) & Kde - [Whitesur](https://github.com/vinceliuice/WhiteSur-kde)
* Icons - slate circle (modified from McMojave-circle)
* Conky - https://www.gnome-look.org/p/1933562

> [!TIP]
> Set applications to follow the system theme to ensure sync with the light and dark mode toggle.

> [!WARNING]
> Title bars & buttons are not following WhiteSur Theme for qt apps on wayland. Temp fix is forcing apps to use xwayland, launch apps with xwayland backend eg., QT_QPA_PLATFORM=xcb okular. or use X11. Track this [issue](https://github.com/vinceliuice/WhiteSur-gtk-theme/issues/1377)

## Extensions :
* AppIndicator
* Caffeine
* Clipboard History
* Custom command Toogle
* Dash to Panel
* Date Menu Formatter
* Quick Settings Tweaks
* User-style-sheet
* User Themes
