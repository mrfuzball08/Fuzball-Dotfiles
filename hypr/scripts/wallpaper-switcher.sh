#!/bin/bash

# --- CONFIGURACIÓN ---
MONITOR="HDMI-A-2"
# ---------------------



# 1. Detección robusta de la firma de Hyprland
ISIG=$HYPRLAND_INSTANCE_SIGNATURE
if [ -z "$ISIG" ]; then
    ISIG=$(hyprctl instances | head -n 1 | cut -d " " -f 2 | sed 's/://')
fi

# 2. Localizar el Socket
SOCKET_PATH="$XDG_RUNTIME_DIR/hypr/$ISIG/.socket2.sock"
if [ ! -S "$SOCKET_PATH" ]; then
    SOCKET_PATH="/tmp/hypr/$ISIG/.socket2.sock"
fi

# 3. Precarga silenciosa (Redirigimos salida a null para evitar spam en logs)
# Como ya son persistentes los workspaces, esto asegura que las imágenes estén listas.
hyprctl hyprpaper preload "/home/mrfuzball/Wallpapers/mikumorada.jpg" > /dev/null
hyprctl hyprpaper preload "/home/mrfuzball/Wallpapers/hatsune-miku-astronaut-anime.jpg" > /dev/null
hyprctl hyprpaper preload "/home/mrfuzball/Wallpapers/miku-purpura.jpg" > /dev/null
hyprctl hyprpaper preload "/home/mrfuzball/Wallpapers/otra-miku-purpura.jpg" > /dev/null

# 4. Bucle Optimizado (Pure Bash)
# Usamos 'read -r' para lectura cruda y rápida.
socat -u UNIX-CONNECT:"$SOCKET_PATH" - | while read -r line; do

    # Filtramos solo eventos de workspace usando funciones internas de Bash (sin grep)
    if [[ "$line" == workspace\>\>* ]]; then

        # Extraemos el ID quitando la parte "workspace>>" (sin cut)
        WORKSPACE_ID="${line#*>>}"

        case $WORKSPACE_ID in
            1) WALLPAPER="/home/mrfuzball/Wallpapers/mikumorada.jpg" ;;
            2) WALLPAPER="/home/mrfuzball/Wallpapers/hatsune-miku-astronaut-anime.jpg" ;;
            3) WALLPAPER="/home/mrfuzball/Wallpapers/miku-purpura.jpg" ;;
            4) WALLPAPER="/home/mrfuzball/Wallpapers/otra-miku-purpura.jpg" ;;
            *) WALLPAPER="" ;; # Ignorar otros workspaces
        esac

        # Ejecutamos el cambio solo si hay wallpaper definido
        if [ -n "$WALLPAPER" ]; then
            hyprctl hyprpaper wallpaper "$MONITOR,$WALLPAPER"
        fi
    fi
done
