#!/usr/bin/env bash
# Captura de pantalla: construccion de la imagen.
#
# Uso:  bash scripts/capturar-01-construccion.sh
#
# El script se autCaptura: invoca a spectacle sobre su propia ventana de
# terminal (konsole), que es la ventana activa en ese momento. Requiere una
# sesion grafica disponible (DISPLAY=:0).

set -euo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=captura-comun.sh
source "$RAIZ/scripts/captura-comun.sh"

SALIDA="$RAIZ/capturas/01-construccion.png"
IMAGEN="docker.io/songbird2026/cowsay-debian:1.0"

export DISPLAY="${DISPLAY:-:0}"
mkdir -p "$RAIZ/capturas"
cd "$RAIZ"

PROMPT='nicolas@utu:~/trabajo-final$'

captura_preparar

echo -e "${PROMPT} docker build -t ${IMAGEN} ."
docker build --no-cache -t "$IMAGEN" . 2>&1 \
    | grep -E '^(STEP|COMMIT|Successfully|-->|Setting up cowsay)'

echo -e "\n${PROMPT} docker images ${IMAGEN}"
docker images "$IMAGEN"

captura_tomar "$SALIDA"

sleep 5
