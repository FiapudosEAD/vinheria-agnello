#!/bin/sh
# Railway injeta a variável PORT dinamicamente.
# Tomcat usa 8080 por padrão — substituímos pelo valor de PORT se definido.
PORT=${PORT:-8080}
sed -i "s/port=\"8080\"/port=\"$PORT\"/" /usr/local/tomcat/conf/server.xml
exec catalina.sh run
