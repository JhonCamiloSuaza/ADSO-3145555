# ============================================================
# Dockerfile - Spring Boot API
# ============================================================
# Multi-stage build para optimizar la imagen final
# ============================================================

# ---- Etapa 1: Build con Maven ----
FROM maven:3.9-eclipse-temurin-17-alpine AS build

WORKDIR /app

# Copiar archivos de dependencias primero (aprovecha cache de Docker)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código fuente y compilar
COPY src ./src
RUN mvn clean package -DskipTests -B

# ---- Etapa 2: Imagen final ----
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiar el JAR compilado desde la etapa de build
COPY --from=build /app/target/*.jar app.jar

# Puerto de la aplicación
EXPOSE 8080

# Comando de ejecución
ENTRYPOINT ["java", "-jar", "app.jar"]
