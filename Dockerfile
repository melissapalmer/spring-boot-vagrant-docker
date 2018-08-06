FROM maven:3.5.3-jdk-8-alpine as TARGET
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ /build/src/
RUN mvn package

# Step : Package image
FROM openjdk:8-jre-alpine
EXPOSE 8080
COPY --from=TARGET /build/target/spring-boot-vagrant-docker.jar app.jar
#To reduce Tomcat startup time we added a system property pointing to "/dev/urandom" as a source of entropy.
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

#https://blog.frankel.ch/dockerfile-maven-based-github-projects/
#https://medium.com/@nieldw/caching-maven-dependencies-in-a-docker-build-dca6ca7ad612
#https://blog.giantswarm.io/getting-started-with-java-development-on-docker/
#http://blog.flurdy.com/2014/11/dont-download-internet-share-maven-ivy-docker.html
#https://dzone.com/articles/a-dockerfile-for-maven-based-github-projects