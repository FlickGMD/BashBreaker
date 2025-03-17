# BashBreaker

**BashBreaker** es un conjunto de scripts en Bash diseñados para romper hashes MD5 y contraseñas de archivos ZIP mediante ataques de diccionario.

## Contenido del repositorio

- **md5Crack.sh**: Script para romper hashes MD5 utilizando un diccionario de contraseñas.
- **DestroyZip.sh**: Script para descifrar archivos ZIP protegidos con contraseña mediante fuerza bruta.
- **Colors.sh**: Archivo auxiliar que proporciona colores a la salida de los scripts.

## Instalación y Uso

Clona el repositorio y asigna permisos de ejecución a los scripts:

```bash
git clone https://github.com/FlickGMD/BashBreaker.git
cd BashBreaker
chmod +x md5Crack.sh DestroyZip.sh
```

### Uso de md5Crack.sh

```bash
./md5Crack.sh -c [CADENA_MD5] -w [WORDLIST]
```

### Ejemplo

```bash
./md5Crack.sh -c e10adc3949ba59abbe56e057f20f883e -w rockyou.txt # Hash md5 proveniente de '123456'
```

**Opciones:**
- `-c` : Especifica el hash MD5 a romper.
- `-w` : Especifica la wordlist con posibles contraseñas.
- `-x` : Oculta el banner.
- `-h` : Muestra el panel de ayuda.

### Uso de DestroyZip.sh

```bash
./DestroyZip.sh -z [ARCHIVO_ZIP] -w [WORDLIST]
```

**Opciones:**
- `-z` : Especifica el archivo ZIP a descifrar.
- `-w` : Especifica la wordlist con posibles contraseñas.
- `-x` : Oculta el banner.
- `-h` : Muestra el panel de ayuda.

### Ejemplo

```bash
./DestroyZip.sh -z test.zip -w rockyou.txt 
```

## Requisitos

Para ejecutar estos scripts, necesitas tener instalados los siguientes paquetes:

```bash
sudo apt install unzip -y # Para distribuciones basadas en Debian.
sudo pacman -S unzip --noconfirm # Para distribuciones basadas en Arch.
```

## Advertencia

Este software ha sido desarrollado con fines educativos y de seguridad. No debe ser utilizado en sistemas sin autorización. El uso indebido de estas herramientas es responsabilidad exclusiva del usuario.

## Autor

Desarrollado por [FlickGMD](https://github.com/FlickGMD).


