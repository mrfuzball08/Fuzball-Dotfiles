#!/bin/bash

# Configuración
WALLPAPER_DIR="$HOME/Wallpapers" # Carpeta de fondos
# ROFI_THEME="theme" # especificar tema de rofi

# Verificar si swww-daemon está corriendo
# if ! pgrep -x "swww-daemon" > /dev/null; then
#     swww-daemon &
#     sleep 0.5
# fi

# Listar imágenes y pasarlas a Rofi
selection=$(ls "$WALLPAPER_DIR" | rofi -dmenu -i -p "Seleccionar Wallpaper:" -config ~/.config/rofi/config.rasi)

# Si el usuario selecciona algo, aplicarlo
if [ -n "$selection" ]; then
  swww img "$WALLPAPER_DIR/$selection" \
    --transition-type center \
    --transition-step 90 \
    --transition-fps 60
fi
