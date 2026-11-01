#!/usr/bin/env bash
# Genera las capturas de pantalla de la entrega.
#
# Uso:  bash scripts/generar-capturas.sh [01-construccion ...]
#
# Cada captura se realiza desde una terminal konsole independiente: el script
# de captura se autCaptura con spectacle sobre su propia ventana, que es la
# ventana activa en ese momento. Por eso NO se puede lanzar un script de
# captura directamente desde esta shell (capturaria otra ventana).
#
# El coordinador no usa esperas fijas: espera a que aparezca el archivo de
# captura definitivo (el script lo renombra desde un .tmp al terminar).
#
# Requiere sesion grafica activa (Wayland/X11).

set -euo pipefail

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

export DISPLAY="${DISPLAY:-:0}"
TIMEOUT=120

if [ "$#" -gt 0 ]; then
    scripts=()
    for nombre in "$@"; do
        scripts+=("$RAIZ/scripts/capturar-${nombre}.sh")
    done
else
    scripts=("$RAIZ"/scripts/capturar-*.sh)
fi

mkdir -p "$RAIZ/capturas"

for script in "${scripts[@]}"; do
    nombre="$(basename "$script" .sh)"
    salida="$RAIZ/capturas/${nombre#capturar-}.png"

    rm -f "$salida" "${salida}.tmp.png"

    echo "==> Generando $nombre"
    konsole --separate --title "nicolas@utu: ~/trabajo-final" -e bash "$script" >/dev/null 2>&1 &

    waited=0
    while [ ! -f "$salida" ] && [ "$waited" -lt "$TIMEOUT" ]; do
        sleep 1
        waited=$((waited + 1))
    done

    if [ -f "$salida" ]; then
        echo "    OK: $salida"
    else
        echo "    ERROR: no se genero $salida (timeout ${TIMEOUT}s)"
        exit 1
    fi

    # Cierra la ventana de konsole de esta captura para no acumular ventanas.
    pkill -f "konsole.*${nombre}" 2>/dev/null || true
    sleep 1
done

echo
echo "Recortando capturas..."
python3 "$RAIZ/scripts/recortar-capturas.py"

echo
echo "Listo. Capturas en $RAIZ/capturas/"
ls -la "$RAIZ/capturas/"
