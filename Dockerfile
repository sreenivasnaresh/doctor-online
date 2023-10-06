# Stage 1: Build the application with Maven
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jre11-slim
COPY --from=build /app/target/doctor-online.war /opt/tomcat9/webapps/
EXPOSE 8080
