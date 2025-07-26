FROM tomcat:9.0-jdk8-openjdk

# Borra las apps por defecto (opcional pero recomendable)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia la carpeta corpus al directorio corpus/ del contenedor
COPY corpus/ corpus/

# Copia tu archivo WAR al directorio de despliegue de Tomcat
COPY dist/EstudioAutopsia.war /usr/local/tomcat/webapps/ROOT.war

# Exponer el puerto 8080 (Tomcat default)
EXPOSE 8080

# El CMD viene por defecto en la imagen base de Tomcat
