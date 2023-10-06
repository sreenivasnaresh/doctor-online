#Stage 1: Build the application with maven
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

#Stage 2: deploy to Tomcat
FROM FROM tomcat:9.0-jre11-slim
COPY --from=build /app/target/doctor-online.war /opt/tomcat9/webapps/
EXPOES 8080
CMD ["catalina.sh", "run"]
 
