# EstudioAutopsia

Sistema de análisis de encuestas sobre autopsias médicas, desarrollado con Java Server Faces (JSF), PrimeFaces y PostgreSQL. Este proyecto se ejecuta mediante contenedores Docker para facilitar su despliegue y portabilidad.

## ⚙️ Requisitos previos

Antes de ejecutar los comandos, asegúrate de tener instalado:

- [Java 8 JDK](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)
- [Apache Ant](https://ant.apache.org/)
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- (Opcional) [GNU Make](https://www.gnu.org/software/make/) — ya disponible por defecto en macOS y Linux.

En Windows se recomienda usar [WSL2](https://learn.microsoft.com/es-es/windows/wsl/install) o [Git Bash](https://gitforwindows.org/) para compatibilidad con Make.

---

# Guía de uso con Makefile

Este proyecto incluye un `Makefile` que automatiza los procesos de compilación, construcción de imágenes, despliegue y gestión de servicios usando Docker y Ant.

---

## 🧰 Comandos disponibles

### Compilar el proyecto

```bash
make build
```
Compila el proyecto usando Ant y genera el archivo `.war` en `dist/`.

### Construir imagen Docker personalizada con el WAR

```bash
make image
```
Construye la imagen del servicio `tomcat` definido en `docker-compose.yml`.

### Desplegar aplicación (compilar + construir imagen + levantar contenedor)

```bash
make deploy
```
Realiza el flujo completo: compila, construye la imagen de Tomcat y levanta únicamente el contenedor de la aplicación.

### Levantar todos los servicios (Tomcat + PostgreSQL)

```bash
make up
```
Inicia tanto la base de datos como la aplicación.

### Detener y eliminar todos los contenedores

```bash
make down
```

### Ver logs de todos los servicios

```bash
make logs
```

### Ver solo los logs del contenedor de Tomcat

```bash
make logs-tomcat
```

### Levantar únicamente el contenedor de PostgreSQL

```bash
make db-up
```

### Detener solo la base de datos

```bash
make db-down
```

### Eliminar imágenes **dangling** (`<none>`)

```bash
make delete-images-none
```

---

## 🌐 Acceder a la aplicación

Una vez desplegado, accede desde tu navegador a:

```
http://localhost:8080/faces/Views/inicio.xhtml
```
