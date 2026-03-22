# debian-setup

Sway setup for Debian 13 (Trixie).

## Stack

| Role | Package |
|---|---|
| Compositor | sway |
| Bar | waybar |
| Launcher | wofi |
| Notifications | mako |
| Terminal | alacritty |
| Lock screen | gtklock |
| Screenshots | grim + slurp |
| Clipboard | wl-clipboard |
| Brightness | brightnessctl |
| Audio | pavucontrol + playerctl |
| File manager | thunar |

## Install

```bash
# 1. Install packages
./install.sh

# 2. Link configs
./link-configs.sh

# 3. Set theme (flexoki-dark or flexoki-light)
~/.config/scripts/switch-theme.sh flexoki-dark
```

Reboot or start sway. If you're on NVIDIA, launch with `sway --unsupported-gpu`.

## Extras

Individual scripts under `extras/` for things not in the Debian repos:

```bash
extras/install-vscode.sh
extras/install-neovim.sh
extras/install-lazygit.sh
```

## Themes

Themes live in `themes/`. Each theme is a folder with CSS/config files for the relevant apps. Switch with:

```bash
~/.config/scripts/switch-theme.sh <theme-name>
```
