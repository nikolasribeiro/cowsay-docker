#!/usr/bin/env bash
# Captura de pantalla: publicacion en Docker Hub y verificacion posterior.
#
# Uso:  bash scripts/capturar-04-publicacion-dockerhub.sh
#
# Demuestra los requisitos 4 y 5: la imagen se publica con la etiqueta 1.0 en
# un repositorio publico de Docker Hub y se puede descargar y ejecutar desde
# alli. Requiere sesion iniciada en Docker Hub:
#
#   docker login docker.io
#
set -euo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=captura-comun.sh
source "$RAIZ/scripts/captura-comun.sh"

SALIDA="$RAIZ/capturas/04-publicacion-dockerhub.png"
IMAGEN="docker.io/nicolasribeiro/cowsay-debian:1.0"

export DISPLAY="${DISPLAY:-:0}"
mkdir -p "$RAIZ/capturas"
cd "$RAIZ"

PROMPT='nicolas@utu:~/trabajo-final$'

captura_preparar

echo -e "${PROMPT} docker push ${IMAGEN}"
docker push "$IMAGEN" 2>&1 | tail -n 5

echo -e "\n${PROMPT} docker rmi ${IMAGEN}"
docker rmi "$IMAGEN" 2>&1 | tail -n 1 || true

echo -e "\n${PROMPT} docker pull ${IMAGEN}"
docker pull "$IMAGEN" 2>&1 | tail -n 3

echo -e "\n${PROMPT} docker run --rm ${IMAGEN} \"Mensaje descargado de Docker Hub\""
docker run --rm "$IMAGEN" "Mensaje descargado de Docker Hub"

captura_tomar "$SALIDA"

sleep 5
