# Getting Started

Posting se puede instalar en cuestión de segundos en MacOS, Linux y Windows.

## Instalación

El método recomendado es usar `uv`, que es un binario de Rust que te permite instalar aplicaciones de Python. Es significativamente más rápido que otras herramientas y te pondrá en marcha con Posting en segundos.

No necesitas preocuparte por instalar Python vos mismo - `uv` se encarga de todo.

### uv

Acá te dejo cómo instalar Posting usando `uv`:

```sh
# instalación rápida en MacOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# instalar Posting (también instalará Python 3.12 si es necesario)
uv tool install --python 3.12 posting

# ejecutar Posting
posting
```

`uv` también se puede instalar vía Homebrew, Cargo, Winget, pipx y más. Consultá la guía de instalación para más información.

`uv` también facilita la instalación de paquetes adicionales de Python en tu entorno de Posting, que podés usar en tus scripts pre-request/post-response.

### pipx

Si preferís, podés instalar Posting vía `pipx`.

```sh
pipx install posting
```

Los métodos anteriores instalarán Posting globalmente, en un entorno aislado. No intentes instalar Posting con `pip`.

**Homebrew no es compatible**

## Una introducción rápida

Esta introducción te mostrará cómo crear una simple solicitud POST a la API de prueba JSONPlaceholder para crear un nuevo usuario. Se enfoca en un flujo de trabajo eficiente con el teclado, pero también podés usar el mouse si preferís.

### Colecciones y solicitudes

Una colección es simplemente un directorio que puede contener solicitudes guardadas por Posting.

Si lanzás Posting sin especificar una colección, cualquier solicitud que crees se guardará en la colección "default".

La colección por defecto es un directorio reservado por Posting en tu sistema de archivos. Es una colección "global" y no está relacionada con el directorio desde el cual lanzaste Posting.

Esto está bien para solicitudes rápidas y desechables, pero probablemente querrás crear una nueva colección para cada proyecto en el que trabajes para poder controlarlo con versionado.

Para crear una nueva colección, simplemente creá un nuevo directorio y pasalo a Posting.

```sh
mkdir my-collection
posting --collection my-collection
```

Ahora, cualquier solicitud que crees se guardará en el directorio `my-collection` como archivos YAML simples con la extensión `.posting.yaml`.

Cuando Posting se abra, verás el navegador de colecciones en el lado izquierdo de la pantalla con `my-collection` mostrado en la esquina inferior derecha.

### Configurando el método de solicitud a POST

Cuando lanzás Posting, no hay ninguna solicitud abierta, así que la interfaz se verá bastante vacía.

Vamos a crear una simple solicitud POST a la API de prueba JSONPlaceholder para crear un nuevo usuario.

Presioná `Ctrl+T` para abrir el menú desplegable del método de solicitud:

El carácter subrayado en cada método indica la tecla que podés presionar para seleccionar rápidamente ese método. Queremos enviar una solicitud POST, así que presioná `P` para seleccionar rápidamente el método POST.

### Configurando la URL de la solicitud

Podés mover el foco hacia adelante y hacia atrás a través de los widgets usando `Tab` y `Shift+Tab` respectivamente. Así que, podés mover el foco del selector de método a la barra de URL presionando `Tab` una vez.

Alternativamente, podés mover inmediatamente el foco a la barra de URL desde cualquier lugar en Posting usando `Ctrl+L`.

Escribí `https://jsonplaceholder.typicode.com/users` en la barra de URL.

La barra de URL de Posting resalta partes de la URL mientras escribís, lo cual puede ser útil para detectar errores tipográficos.

También puede autocompletar dominios que hayas usado previamente, para ahorrarte tener que volver a escribirlos. Por ejemplo, si más tarde querés hacer una solicitud a `https://jsonplaceholder.typicode.com/posts`, simplemente escribí "json" en la barra de URL y seleccioná la URL del menú de autocompletar que aparece.

### Agregando un cuerpo JSON

Presioná `Ctrl+O` para entrar en "modo salto", luego presioná `W` para saltar rápidamente a la pestaña "Body". El modo salto es genial para moverte rápidamente a través de la interfaz sin tener que presionar `Tab` múltiples veces.

En este punto, el foco está actualmente en la barra de pestañas. Presioná `J` (o `Down`) para mover el cursor hacia abajo al menú desplegable. Presioná `Enter` para abrirlo, luego seleccioná la opción `Raw (json, text, etc.)`.

Movete hacia abajo al área de texto usando `J` (o `Down`), y escribí (o pegá) el JSON a continuación.

```json
{
  "name": "John Doe",
  "username": "johndoe",
  "email": "john.doe@example.com"
}
```

Notá que en la esquina inferior derecha del área de texto, JSON está preseleccionado como el tipo de contenido. Esto significa que Posting usará automáticamente el resaltado de sintaxis JSON y agregará el encabezado `Content-Type: application/json` por vos cuando se envíe la solicitud.

### Viendo los atajos de teclado

Ahora es probablemente un buen momento para notar que podés ver la lista completa de atajos de teclado para el widget enfocado presionando `F1`. El widget del área de texto en particular tiene muchos atajos útiles y soporta cosas como deshacer/rehacer.

### Enviando la solicitud

Presioná `Ctrl+J` para enviar la solicitud. Este atajo funciona globalmente.

También podés enviar la solicitud usando `Alt+Enter`. Esto solo funciona en terminales que soportan el protocolo de teclado Kitty.

### Trabajando con la respuesta

La respuesta se mostrará en el cuerpo principal de la interfaz. Presioná `Ctrl+O` para entrar en "modo salto", y luego `A` para moverte a la pestaña del cuerpo de la respuesta.

Presioná `J` o `Down` para mover el cursor hacia abajo en el cuerpo de la respuesta. Esta área de texto soporta un montón de atajos de teclado diferentes para navegar rápidamente por el cuerpo de la respuesta. El texto puede ser seleccionado manteniendo presionada la tecla `Shift` y moviendo el cursor usando las teclas de flecha (o las teclas `hjkl` para los fans de Vim). También podés seleccionar texto haciendo clic y arrastrando con el mouse.

Presioná `Y` o `C` para copiar el texto seleccionado al portapapeles. Si no hay texto seleccionado, se copiará todo el cuerpo de la respuesta.

### Guardando la solicitud

Finalmente, presioná `Ctrl+S` para guardar la solicitud en el disco. Completá el formulario en el modal que aparece, y presioná `Enter` o `Ctrl+N` para escribir la solicitud en el disco.

Las solicitudes pueden ser guardadas en carpetas - simplemente incluí un `/` en el campo `Path in collection` cuando guardes la solicitud, y Posting creará la estructura de directorios requerida por vos.

