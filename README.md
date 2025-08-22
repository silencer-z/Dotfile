# My dotfiles

## fcitx5
```shell
yay -S fcitx5-rime fcitx5 fcitx5-theme-macos12
```

```
# /etc/environment

XMODIFIERS=@im=fcitx
# GTK_IM_MODULE=fcitx 须在各个版本下的配置文件中单独设置，不能在总环境中设置
QT_IM_MODULE=fcitx
```

```
#hyprland.conf

exec-once = fcitx5 -d
```

```
#hyprland.conf

env = ELECTRON_ARGS="--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
```

TODO)): switch the input methed the icon in mess

## sddm
```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
```
您可以通过编辑元数据（ /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop ） 来选择主题。
ConfigFile=Themes/astronaut.conf


hyprctl dispatch exit   # logout form Terminal


TODO)): 1. modify the screen it shows
        2. disable the boder colors
        3. chinese layout dont fit
        4. signin cost time


## hyprpaper

```shell
touch $HOME/.config/hypr/hyprpaper.conf
```

```
# hyprpaper.conf

preload = $HOME/.config/hypr/wallpaper/purple_leaves.png
wallpaper = ,$HOME/.config/hypr/wallpaper/purple_leaves.png

```

```
# hyprland.conf

exec-once = hyprpaper

```

## neovim

```bash
yay -S neovim
```

Make a backup of your current Neovim files:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

Clone the starter

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Remove the .git folder, so you can add it to your own repo later

```bash
rm -rf ~/.config/nvim/.git
```

Start Neovim!




## waybar

## uwsm

## clash-verge

```shell
yay -S clash-verge
```

```
# /etc/enviroment

# [proxy]
http_proxy=127.0.0.1:7897
https_proxy=127.0.0.1:7897
all_proxy=127.0.0.1:7897

```


```
# ~/.gitconfig

[https]
	proxy = https://127.0.0.1:7897
```


## kitty

## fonts

```shell
yay -S noto-fonts noto-fonts-extra opendesktop-fonts ttf-dejavu ttf-jetbrains-mono-nerd ttf-liberation ttf-maplemono-nf ttf-maplemono-nf-cn
```

## zsh

yay -S zsh zinit


## rofi-wayland
