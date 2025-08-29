FROM maven:3.9.11-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
EXPOSE 8180
RUN mvn clean package -Dmaven.test.skip=true -Dpmd.skip=true -Dcheckstyle.skip=true

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
