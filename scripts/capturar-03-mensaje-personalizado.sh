#!/usr/bin/env bash
# Captura de pantalla: ejecucion con un mensaje personalizado.
#
# Uso:  bash scripts/capturar-03-mensaje-personalizado.sh
#
# Demuestra el requisito 3: el usuario indica su propio mensaje al ejecutar
# el contenedor, sin modificar ni reconstruir la imagen.

set -euo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=captura-comun.sh
source "$RAIZ/scripts/captura-comun.sh"

SALIDA="$RAIZ/capturas/03-mensaje-personalizado.png"
IMAGEN="docker.io/songbird2026/cowsay-debian:1.0"
MENSAJE="Hola UTU! Mensaje del usuario"

export DISPLAY="${DISPLAY:-:0}"
mkdir -p "$RAIZ/capturas"
cd "$RAIZ"

PROMPT='nicolas@utu:~/trabajo-final$'

captura_preparar

echo -e "${PROMPT} docker run --rm ${IMAGEN} \"${MENSAJE}\""
docker run --rm "$IMAGEN" "$MENSAJE"

captura_tomar "$SALIDA"

sleep 5
