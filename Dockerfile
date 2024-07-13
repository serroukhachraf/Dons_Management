FROM openjdk:17-jdk-slim

LABEL maintainer="achrafsserroukh01@gmail.com"

WORKDIR /app

COPY target/organdonation-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
