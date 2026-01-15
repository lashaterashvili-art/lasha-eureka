# Build stage
#
FROM public.ecr.aws/docker/library/maven:3.8.3-openjdk-11 AS build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package


FROM public.ecr.aws/docker/library/ibm-semeru-runtimes:open-11-jdk

COPY --from=build /app/target/keepz-wallet-eureka-server-0.0.1-SNAPSHOT.jar /app/app.jar

WORKDIR /app

ENTRYPOINT ["java","-Dspring.profiles.active=local", "-jar", "app.jar"]
