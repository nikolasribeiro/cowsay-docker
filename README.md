# 🐮 Cowsay — Equipo Songbird

Imagen de Docker con [cowsay](https://en.wikipedia.org/wiki/Cowsay) que muestra un
mensaje predeterminado del equipo y permite al usuario escribir el que quiera,
sin necesidad de modificar ni reconstruir la imagen.

| | |
|---|---|
| **Imagen en Docker Hub** | [`docker.io/songbird2026/cowsay-debian:1.0`](https://hub.docker.com/r/songbird2026/cowsay-debian) |
| **Repositorio (código fuente)** | [`github.com/nikolasribeiro/cowsay-docker`](https://github.com/nikolasribeiro/cowsay-docker) |
| **Etiqueta** | `1.0` |
| **Arquitectura** | `linux/amd64` |

---

## 👥 Equipo

**Equipo Songbird** — Proyecto Anual 2026

- Juan de la Vega
- Leandro Conte
- Nicolas Pereyra
- Nicolas Ribeiro

---

## 📦 Descripción de la imagen

La imagen parte de `debian:bookworm-slim` y le instala el paquete `cowsay`
mediante `apt-get`. Al ejecutarla, muestra la vaca de cowsay con un mensaje
dentro del bocadillo.

- **Mensaje por defecto:** `Equipo Songbird - Proyecto Anual`
- **Mensaje del usuario:** se indica como argumento al ejecutar el contenedor y
  reemplaza al predeterminado.
- **Tamaño aproximado:** 128 MB
- **Usuario:** root (no se requiere usuario adicional para ejecutarla)

### Cómo funciona

El `Dockerfile` define:

- `ENTRYPOINT ["cowsay"]` — el programa que siempre se ejecuta.
- `CMD ["Equipo Songbird - Proyecto Anual"]` — el mensaje por defecto.

Cuando se ejecuta `docker run IMAGEN "otro mensaje"`, Docker reemplaza el `CMD`
por el argumento del usuario y mantiene el `ENTRYPOINT`, por lo que `cowsay`
recibe ese texto en lugar del predeterminado. **No hace falta reconstruir la
imagen.**

> **Nota técnica:** en Debian el paquete `cowsay` instala el binario en
> `/usr/games/cowsay`, una ruta que no forma parte del `PATH` por defecto. El
> `Dockerfile` crea un enlace simbólico en `/usr/local/bin/cowsay` para que el
> comando quede disponible para cualquier usuario.

---

## 🔨 Construir la imagen

Clonar el repositorio y construir la imagen desde la raíz del proyecto:

```bash
git clone https://github.com/nikolasribeiro/cowsay-docker.git
cd cowsay-docker
docker build -t docker.io/songbird2026/cowsay-debian:1.0 .
```

Comprobar que la imagen quedó creada:

```bash
docker images docker.io/songbird2026/cowsay-debian:1.0
```

---

## ▶️ Ejecutar el contenedor

### Con el mensaje predeterminado

```bash
docker run --rm docker.io/songbird2026/cowsay-debian:1.0
```

Salida:

```
 __
< Equipo Songbird - Proyecto Anual  >
 --
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

### Con un mensaje personalizado

Basta con pasar el texto como argumento:

```bash
docker run --rm docker.io/songbird2026/cowsay-debian:1.0 "Hola UTU! Mensaje del usuario"
```

Salida:

```
 _______________________________
< Hola UTU! Mensaje del usuario >
 -------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

### Opciones adicionales de cowsay

Como la imagen expone `cowsay` directamente, también acepta sus banderas
propias. Por ejemplo, para cambiar la figura:

```bash
docker run --rm docker.io/songbird2026/cowsay-debian:1.0 -f tux "Hola con un tux"
```

---

## ⬇️ Descargar desde Docker Hub

No hace falta construir nada: la imagen publicada se puede descargar directamente.

```bash
docker pull docker.io/songbird2026/cowsay-debian:1.0
```

Verificar la descarga:

```bash
docker images docker.io/songbird2026/cowsay-debian:1.0
```

Y ejecutarla:

```bash
docker run --rm docker.io/songbird2026/cowsay-debian:1.0 "Gracias por usar nuestra imagen"
```

La imagen también se puede consultar desde el sitio web de Docker Hub:
<https://hub.docker.com/r/songbird2026/cowsay-debian>

---

## 📤 Publicar la imagen

Para actualizar la imagen publicada desde este repositorio:

```bash
# 1. Iniciar sesión (Personal Access Token de Docker Hub)
docker login docker.io

# 2. Construir
docker build -t docker.io/songbird2026/cowsay-debian:1.0 .

# 3. Publicar
docker push docker.io/songbird2026/cowsay-debian:1.0
```

---

## 📸 Capturas de pantalla

Las evidencias se encuentran en [`capturas/`](capturas/) y se regeneran con:

```bash
bash scripts/generar-capturas.sh
```

| Archivo | Evidencia |
|---|---|
| `capturas/01-construccion.png` | Construcción de la imagen con `docker build` |
| `capturas/02-mensaje-predeterminado.png` | Ejecución con el mensaje predeterminado |
| `capturas/03-mensaje-personalizado.png` | Ejecución con un mensaje del usuario |
| `capturas/04-publicacion-dockerhub.png` | Publicación en Docker Hub y verificación posterior |

---

## 📁 Estructura del proyecto

```
.
├── Dockerfile              # definición de la imagen
├── README.md               # este documento
├── .dockerignore           # excluye archivos del contexto de build
├── capturas/               # evidencias en PNG
└── scripts/
    ├── captura-comun.sh            # utilidades compartidas
    ├── capturar-01-construccion.sh
    ├── capturar-02-mensaje-predeterminado.sh
    ├── capturar-03-mensaje-personalizado.sh
    ├── capturar-04-publicacion-dockerhub.sh
    ├── generar-capturas.sh         # coordina la generación
    └── recortar-capturas.py        # recorta el área vacía de las imágenes
```

---

## 📄 Licencia

MIT.
