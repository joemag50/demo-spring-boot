# Etapa 1: Construcción del JAR
FROM gradle:8.8-jdk17 AS builder
WORKDIR /home/gradle/project

# Copia el contenido del proyecto al contenedor
COPY . .

# Construye el JAR del proyecto
RUN gradle clean bootJar

# Etapa 2: Construcción de la imagen final
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copia el JAR construido desde la etapa anterior
COPY --from=builder /home/gradle/project/build/libs/*.jar /app/app.jar

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
