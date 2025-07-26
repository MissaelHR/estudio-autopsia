.PHONY: all build prepare image deploy up down logs logs-tomcat db-up db-down clean

# Configuración de variables
WAR_NAME       := EstudioAutopsia.war
WAR_SRC        := dist/$(WAR_NAME)
PG_CONTAINER   := postgres
PG_DB          := encuesta
PG_USER        := postgres
PG_PASSWORD    := password
TOMCAT_SERVICE := tomcat
DB_SERVICE     := postgres

# Target por defecto
all: deploy

# Compilación del proyecto con Ant
build:
	@echo "Compilando WAR con Ant..."
	ant clean dist

# Construcción de la imagen Docker del servicio Tomcat
image: prepare
	@echo "Construyendo imagen Docker de $(TOMCAT_SERVICE)..."
	docker-compose build $(TOMCAT_SERVICE)

# Despliegue completo: compila, construye imagen y levanta contenedor Tomcat
deploy: build image
	@echo "Desplegando contenedor $(TOMCAT_SERVICE)..."
	docker-compose up -d $(TOMCAT_SERVICE)

# Levantar todos los servicios definidos en docker-compose
up:
	@echo "Levantando todos los servicios (Tomcat + PostgreSQL)..."
	docker-compose up -d

# Detener y eliminar todos los servicios
down:
	@echo "Deteniendo y eliminando todos los servicios..."
	docker-compose stop

# Mostrar logs de todos los contenedores
logs:
	docker-compose logs -f

# Mostrar logs solamente del contenedor Tomcat
logs-tomcat:
	docker-compose logs -f $(TOMCAT_SERVICE)

# Levantar solo la base de datos
db-up:
	@echo "Levantando servicio de base de datos..."
	docker-compose up -d $(DB_SERVICE)

# Detener solo la base de datos
db-down:
	@echo "Deteniendo servicio de base de datos..."
	docker-compose stop $(DB_SERVICE)

# Limpiar imagenes
delete-images-none: docker rmi $(docker images -f "dangling=true" -q)

# Para formato .dump binario generado con pg_dump -Fc
DUMP_FILE := db/backup.dump

db-import:
	@echo "Importando archivo .dump binario..."
	docker cp $(DUMP_FILE) $(PG_CONTAINER):/tmp/backup.dump
	docker exec -e PGPASSWORD=$(PG_PASSWORD) $(PG_CONTAINER) \
		pg_restore -U $(PG_USER) -d $(PG_DB) --clean /tmp/backup.dump

# Crear un dump completo en formato .dump binario
db-dump-bin:
	@echo "Creando dump binario de la base de datos..."
	docker exec -e PGPASSWORD=$(PG_PASSWORD) $(PG_CONTAINER) \
		pg_dump -U $(PG_USER) -d $(PG_DB) -F c -f /tmp/backup.dump
	docker cp $(PG_CONTAINER):/tmp/backup.dump db/backup.dump
	@echo "Dump binario guardado en db/backup.dump"