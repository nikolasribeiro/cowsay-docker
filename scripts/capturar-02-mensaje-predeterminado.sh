#!/usr/bin/env bash
# Captura de pantalla: ejecucion con el mensaje predeterminado.
#
# Uso:  bash scripts/capturar-02-mensaje-predeterminado.sh
#
# Demuestra el requisito 2: al ejecutar el contenedor sin argumentos, cowsay
# muestra el mensaje que identifica al equipo.

set -euo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=captura-comun.sh
source "$RAIZ/scripts/captura-comun.sh"

SALIDA="$RAIZ/capturas/02-mensaje-predeterminado.png"
IMAGEN="docker.io/nicolasribeiro/cowsay:1.0"

export DISPLAY="${DISPLAY:-:0}"
mkdir -p "$RAIZ/capturas"
cd "$RAIZ"

PROMPT='nicolas@utu:~/trabajo-final$'

captura_preparar

echo -e "${PROMPT} docker run --rm ${IMAGEN}"
docker run --rm "$IMAGEN"

captura_tomar "$SALIDA"

sleep 5
