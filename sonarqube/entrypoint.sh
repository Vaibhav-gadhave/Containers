#!/bin/bash
# Start SonarQube
su sonar -c "/opt/sonarqube/bin/linux-x86-64/sonar.sh start"

# Start Nginx
nginx -g "daemon off;"
