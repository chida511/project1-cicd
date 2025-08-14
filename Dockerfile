## Artifact build stage
FROM maven AS buildstage
# Create a working directory for your project
RUN mkdir /opt/project1-cicd
WORKDIR /opt/project1-cicd

# Copy all project files
COPY . .

# Build the artifact (.war)
RUN mvn clean install

### Tomcat deploy stage
FROM tomcat

# Set the working directory to webapps
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file from the build stage
COPY --from=buildstage /opt/project1-cicd/target/*.war .

# Remove default ROOT and rename WAR to ROOT.war
RUN rm -rf ROOT && mv *.war ROOT.war

# Expose default Tomcat port
EXPOSE 8080
