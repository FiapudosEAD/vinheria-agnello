# ── Etapa 1: compilar com Maven ──────────────────────────────────────────────
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copia o pom.xml primeiro para aproveitar o cache de dependências
COPY pom.xml .
RUN mvn dependency:go-offline -q

# Copia o restante do projeto e gera o WAR
COPY src/ src/
COPY webapp/ webapp/
RUN mvn clean package -DskipTests -q

# ── Etapa 2: imagem final com Tomcat ─────────────────────────────────────────
FROM tomcat:10.1-jre17-temurin

# Remove o app padrão do Tomcat e implanta o nosso como ROOT (url raiz /)
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Ativa o perfil de produção (H2 em memória, sem arquivo local)
ENV JAVA_OPTS="-Dapp.env=prod"

# Script de entrada: ajusta a porta do Tomcat para a variável PORT do Railway
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
