# First stage: Install Maven
FROM openjdk:17-jdk-slim AS maven_installer

WORKDIR /maven

# Define the desired Maven version
ARG MAVEN_VERSION=3.8.4

# Download and install Maven
RUN apt-get update && apt-get install -y wget tar \
    && wget -q "https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -O maven.tar.gz \
    && tar -xzf maven.tar.gz --strip-components=1 \
    && rm maven.tar.gz

# Second stage: build the application with Maven
FROM maven_installer AS builder
            
WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src/ /app/src/

RUN /maven/bin/mvn clean package

# Second stage: run the application with OpenJDK
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar .

EXPOSE 8090

CMD ["java", "-jar", "online.jar"]

