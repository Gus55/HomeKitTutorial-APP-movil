# HomeKitTutorial-APP-movil
Tutorial HomeKit para prender y apagar foco

El objetivo de la aplicación es probar la funcionalidad de HomeKit al interactuar con accesorios externos a una computadora, haciendo uso de un simulador de accesorios para las personas que no cuentan con dispositivos físicos. Esta aplicación hará la función de prender y apagar uno o más focos dentro de una o más casas.


## Requisitos
- Tener una versión de Xcode 10 o superior
- Haber instalado **Homekit Accesory Simulator** (la versiòn dependera de tu versión de MacOS )
- Simulador IOS device
- Apple ID

## Instalación Homekit Simulator
1. Crear un proyecto en Xcode
2. Dirigirse al primer archivo del proyecto
![enter image description here](https://lh3.googleusercontent.com/KnckfabX-627Okn-6qleYXPv-IRRga5s2wbO21bOrCl2pflUNjTT0-eB510DILwPSGbg0r6779l0)
3. Dar click en el botón de capabilities
4. Dirigirse a la sección de Homekit y dar click en _Download HomeKit simulator_
![enter image description here](https://lh3.googleusercontent.com/tR80Ti8R2YJxPUy0b4G3ID8Q4hdYE-iyGTBT9JW0scasVcVyozd5FlD6KOoERtUsoJVRZ8TRkBGI)
5. Te redirigirla a una pagina de descargas de Apple Developer y seleccionaras el paquete seleccionado
![enter image description here](https://lh3.googleusercontent.com/nRpWSw6C3TF7GjGCipxdl3eW1Es3xJHxowQIl3NIgKQ5OcjSuoH6iAkIqUOHuaj7fVJwIClH1t4U)

6. Una vez descargado, Abrelo y entra a la carpeta Hardware.
7. Mueve el programa **HomeKit Access Simulator** a la raíz de tu proyecto
8. Ejecuta el programa

## Como utilizar HomeKit Simulator
1. Una vez que hayas abierto el programa te aparecerá una pantalla vacía y te dirigirás al botón de **+** en la esquina inferior izquierda y caras click.
2. Seleccionaras **new accesory/bridge**
3. Se desplegara un formulario donde pondrás el nombre a tu accesorio y en la parte de categoría seleccionaras _LightBulb_ (El resto de los campos puedes dejarlos vacios).
4. Da click en finish y te saldrá la siguiente pantalla
![enter image description here](https://lh3.googleusercontent.com/SyTJWPeCytDK0KGBb1QB4T8eWBZ6IKcqZ6auA9CCtQrlaMUfJUhnmGqZq4qzSnnCiMhMkuM0jc74)
5. Daras click en el botón **add service**
6. En la parte de servicio escogerás _LightBulb_ y en name le darás un nombre a tu servicio.
7. Dar click en finish
8. Haz creado un foco para utilizar en tu app

## Como utilizar la app
1. Cuando inicies la app se te pedirá permiso para acceda a los datos de tu dispositivo, acepta para poder continuar
2. Cuando inicies la app veras un botón de **+**  en la parte superior derecha con el que podrás agregar casas para que estás se comuniquen con los dispositivos. Crea una casa y asignale un nombre
3. Te aparecerá una casa creada, presiona la casa y reedirigira a la pantalla de accesorios
4. En la pantalla de accesorios podrás ver los dispositivos que están conectados con tu casa.
5. Al principio no tendrás accesorios por que tienes que buscar accesorios usando el botón que tiene un icono de lupa.
6. Te aparecerán varios mensajes los cuales tienes que aceptar para que finalmente el dispositivo pueda enlazarse con el accesorio o foco.
7. Un mensaje importante que debes considera al conectar tu foco es el siguiente.
![enter image description here](https://lh3.googleusercontent.com/7RBlwNV643ScSuiYhVGHybBnKdChbBgN2vMLS5k7NVy80zDVm1d6jaiTu-Bz7WOzQwwVJIGfh0v2)

Se te pedira un password el cual obtendrás de 

![enter image description here](https://lh3.googleusercontent.com/g-X3NrWhDBDhkwSlbmi2lLjJAtccLk16rtXQWX3jpHaCk3aIx9-bIID0WriNOmc-6VqVsO3SFzWf)

9. Ahora puedes prender y apagar un foco.

Video tutorial
https://drive.google.com/file/d/1-pebX5fMcgrQQYI0XQ2H8CxYQKYKNKpE/view
