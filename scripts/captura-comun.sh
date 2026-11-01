#!/usr/bin/env bash
# Utilidad compartida por los scripts de captura.
#
# Los scripts se ejecutan dentro de una ventana de konsole aparte y se
# autCapturan con spectacle (que captura la ventana activa). Para que el
# proceso que las coordina no dependa de tiempos de espera fijos, cada script
# escribe primero en un archivo temporal y lo renombra al terminar: el
# coordinador detecta el renombrado como senal de finalizacion.

# Prepara el terminal antes de mostrar el bloque de comando.
captura_preparar() {
    stty sane 2>/dev/null || true
    printf '\033[2J\033[H'
}

# Captura la ventana activa (la de konsole actual) hacia un archivo temporal.
captura_tomar() {
    local destino="$1"
    local temporal="${destino}.tmp.png"

    sleep 2
    spectacle -b -n -a -o "$temporal"
    mv -f "$temporal" "$destino"
    printf '\n[Captura guardada en %s]\n' "$destino"
}
