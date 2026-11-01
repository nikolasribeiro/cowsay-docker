#!/usr/bin/env python3
"""Recorta el area vacia inferior de las capturas de terminal.

Las capturas se toman de una ventana de konsole a pantalla completa, por lo
que suelen quedar decenas de filas vacias debajo del ultimo comando. Este
script detecta la ultima fila que contiene texto y recorta la imagen, dejando
un margen inferior pequeno.

La deteccion se hace por brillo: el texto del terminal es claro sobre un
fondo oscuro uniforme. Se ignoran las columnas de la derecha, donde esta la
barra de desplazamiento de konsole.

Uso:  python3 scripts/recortar-capturas.py [archivo.png ...]
"""

import sys
from pathlib import Path

from PIL import Image

RAIZ = Path(__file__).resolve().parent.parent

# Umbral de luminancia por encima del cual un pixel se considera texto.
UMBRAL = 90


def recortar(ruta: Path) -> None:
    imagen = Image.open(ruta).convert("RGB")
    ancho, alto = imagen.size
    pixeles = imagen.load()

    # La barra de desplazamiento de konsole ocupa las ultimas columnas.
    limite_x = int(ancho * 0.92)

    ultima = 0
    for y in range(alto - 1, -1, -1):
        for x in range(0, limite_x, 2):
            r, g, b = pixeles[x, y]
            if 0.299 * r + 0.587 * g + 0.114 * b > UMBRAL:
                ultima = y
                break
        if ultima:
            break

    if ultima == 0:
        print(f"{ruta.name}: no se detecto texto, se deja sin tocar")
        return

    nuevo_alto = min(alto, ultima + 24)
    if nuevo_alto >= alto - 1:
        print(f"{ruta.name}: ya esta recortada ({ancho}x{alto})")
        return

    imagen.crop((0, 0, ancho, nuevo_alto)).save(ruta, optimize=True)
    print(f"{ruta.name}: {ancho}x{alto} -> {ancho}x{nuevo_alto}")


def main() -> None:
    if len(sys.argv) > 1:
        rutas = [Path(a) for a in sys.argv[1:]]
    else:
        rutas = sorted((RAIZ / "capturas").glob("*.png"))

    for ruta in rutas:
        if ruta.is_file():
            recortar(ruta)


if __name__ == "__main__":
    main()
