# Usar la imagen oficial de Maven para construir el proyecto
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY demo/demo/pom.xml .
COPY demo/demo/src ./src
RUN mvn clean package -DskipTests

# Usar la imagen oficial de OpenJDK para ejecutar el proyecto
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
