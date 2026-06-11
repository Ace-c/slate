# slate 

<img width="1920" height="1080" alt="Screenshot From 2026-06-06 19-33-49" src="https://github.com/user-attachments/assets/31788702-08f7-4306-8a12-a861e707c7e5" />
<img width="1920" height="1080" alt="Screenshot From 2026-06-12 01-19-47" src="https://github.com/user-attachments/assets/2de3eff4-1582-45c3-b7fb-f0a1d438f41a" />



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
