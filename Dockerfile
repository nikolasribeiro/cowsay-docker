FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="Cowsay - Grupo 3°ML" \
    org.opencontainers.image.description="Contenedor con cowsay que muestra un mensaje predeterminado del equipo, configurable por el usuario." \
    org.opencontainers.image.authors="Grupo 3°ML - Juan de la Vega, Leandro Conte, Nicolas Pereyra, Nicolas Ribeiro" \
    org.opencontainers.image.licenses="MIT"

RUN apt-get update \
    && apt-get install -y --no-install-recommends cowsay \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/games/cowsay /usr/local/bin/cowsay

ENTRYPOINT ["cowsay"]
CMD ["Grupo 3°ML - Proyecto Anual UTU 2026"]
