FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml /app
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

#stage 2
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.war /app/myapp.war
EXPOSE 8090
CMD ["java", "-jar", "myapp.jar"]


