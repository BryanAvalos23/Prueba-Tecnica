FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

RUN chmod +x mvnw && ./mvnw -B clean verify

FROM eclipse-temurin:21-jdk AS runtime

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

ARG APP_SECRET=demo-secret
ENV APP_SECRET=${APP_SECRET}

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]