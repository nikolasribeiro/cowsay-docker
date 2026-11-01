# syntax=docker/dockerfile:1

# Imagen base Linux mínima con cowsay disponible en los repos de Debian.
FROM docker.io/library/debian:bookworm-slim

LABEL org.opencontainers.image.title="Cowsay - Grupo 3°ML" \
      org.opencontainers.image.description="Contenedor con cowsay que muestra un mensaje predeterminado del equipo, configurable por el usuario." \
      org.opencontainers.image.authors="Grupo 3°ML - Juan de la Vega, Leandro Conte, Nicolas Pereyra, Nicolas Ribeiro" \
      org.opencontainers.image.licenses="MIT"

# cowsay se instala en /usr/games, que no forma parte del PATH por defecto.
# El symlink a /usr/local/bin lo deja ejecutable desde cualquier usuario.
RUN apt-get update \
    && apt-get install -y --no-install-recommends cowsay \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/games/cowsay /usr/local/bin/cowsay

# ENTRYPOINT fijo: cowsay siempre es el programa ejecutado.
# CMD define el mensaje por defecto; cualquier argumento que pase el usuario
# en `docker run` reemplaza el CMD sin necesidad de reconstruir la imagen.
ENTRYPOINT ["cowsay"]
CMD ["Grupo 3°ML - Proyecto Anual UTU 2026"]
