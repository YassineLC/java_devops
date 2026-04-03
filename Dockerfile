# Build stage
FROM gradle:8.13-jdk21-jammy AS builder
WORKDIR /app
COPY . .
RUN gradle clean build -x test
# Runtime stage
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
