# Stage 1: Build the Java classes
FROM eclipse-temurin:17-jdk as builder
WORKDIR /app

# Copy source code and libraries
COPY src/main/java ./src/main/java
COPY src/main/webapp/WEB-INF/lib ./lib

# Create output directory for compiled classes
RUN mkdir -p build/classes

# Compile the Java files using the libraries in the classpath
RUN find src/main/java -name "*.java" > sources.txt && \
    javac -cp "lib/*" -d build/classes @sources.txt

# Stage 2: Setup Tomcat 9 (must be Tomcat 9 to support javax.servlet)
FROM tomcat:9.0-jre17

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy web resources (JSP, CSS, HTML, WEB-INF) to the ROOT application
# This means your app will be accessible at domain.com/ instead of domain.com/CampusConnect/
COPY src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY xml /usr/local/tomcat/webapps/ROOT/xml

# Copy the compiled Java classes from the builder stage
COPY --from=builder /app/build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# Expose port 8080 (which Render/Railway will route traffic to)
EXPOSE 8080

CMD ["catalina.sh", "run"]
