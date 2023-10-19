FROM jenkins/jenkins:lts
RUN apt-get update && apt-get install -y maven

# Second stage: build the application with Maven
FROM maven:3.8.3-openjdk-17 AS builder
            
WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src/ /app/src/

RUN mvn clean package

# Second stage: run the application with OpenJDK
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar .

EXPOSE 8090

CMD ["java", "-jar", "online.jar"]

