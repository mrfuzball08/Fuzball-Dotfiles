#!/bin/bash

# copiar archivos de mi carpeta local de configuracion a la carpeta con el repo

cp -r ~/.config/hypr ~/Fuzball-Dotfiles/

cp -r ~/.config/waybar ~/Fuzball-Dotfiles/

cp -r ~/.config/rofi ~/Fuzball-Dotfiles/

cp -r ~/Fuzball-Scripts/* ~/Fuzball-Dotfiles/Scripts/

echo "Dotfiles sincronizados correctamente!! :D"
