FROM debian:bookworm-slim

LABEL org.opencontainers.image.title="Cowsay - Equipo Songbird" \
      org.opencontainers.image.description="Contenedor con cowsay que muestra un mensaje predeterminado del equipo, configurable por el usuario." \
      org.opencontainers.image.authors="Equipo Songbird - Juan de la Vega, Leandro Conte, Nicolas Pereyra, Nicolas Ribeiro" \
      org.opencontainers.image.licenses="MIT"

RUN apt-get update \
    && apt-get install -y --no-install-recommends cowsay \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/games/cowsay /usr/local/bin/cowsay

ENTRYPOINT ["cowsay"]
CMD ["Equipo Songbird - Proyecto Anual"]
