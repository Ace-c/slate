# slate 

<img width="1920" height="1080" alt="Screenshot From 2026-07-03 03-01-34" src="https://github.com/user-attachments/assets/e6a10d6b-1185-493d-869e-589f00259902" />
<img width="1920" height="1080" alt="Screenshot From 2026-06-16 05-13-58" src="https://github.com/user-attachments/assets/5f612c5c-a7da-49bb-bf4a-0003702da9bf" />
<img width="1920" height="1080" alt="Screenshot From 2026-06-15 03-06-23" src="https://github.com/user-attachments/assets/a468ed70-d8a6-4d43-b797-4c7db610956b" />


&nbsp;
## Installation :
> [!NOTE]
> Tested on Debian 13 GNOME 48

> [!CAUTION]
> **Backup is advised, since this script will override your configs**

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
