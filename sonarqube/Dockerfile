# Use the official Ubuntu base image
FROM ubuntu:20.04

# Environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and required packages
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    nginx \
    sudo \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SonarQube
RUN mkdir -p /sonarqube/ && \
    cd /sonarqube/ && \
    curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.3.0.34182.zip && \
    unzip -o sonarqube-8.3.0.34182.zip -d /opt/ && \
    mv /opt/sonarqube-8.3.0.34182/ /opt/sonarqube && \
    groupadd sonar && \
    useradd -c "SonarQube - User" -d /opt/sonarqube/ -g sonar sonar && \
    chown sonar:sonar /opt/sonarqube/ -R && \
    cp /opt/sonarqube/conf/sonar.properties /root/sonar.properties_backup && \
    echo "sonar.jdbc.username=sonar" > /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.jdbc.password=admin123" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.jdbc.url=jdbc:postgresql://postgres/sonarqube" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.web.host=0.0.0.0" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.web.port=9000" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.web.javaAdditionalOpts=-server" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.log.level=INFO" >> /opt/sonarqube/conf/sonar.properties && \
    echo "sonar.path.logs=logs" >> /opt/sonarqube/conf/sonar.properties

# Configure Nginx
RUN rm -rf /etc/nginx/sites-enabled/default && \
    rm -rf /etc/nginx/sites-available/default && \
    echo "server{\n\
    listen 80;\n\
    server_name sonarqube.groophy.in;\n\
    access_log /var/log/nginx/sonar.access.log;\n\
    error_log /var/log/nginx/sonar.error.log;\n\
    proxy_buffers 16 64k;\n\
    proxy_buffer_size 128k;\n\
    location / {\n\
        proxy_pass http://127.0.0.1:9000;\n\
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;\n\
        proxy_redirect off;\n\
        proxy_set_header Host \$host;\n\
        proxy_set_header X-Real-IP \$remote_addr;\n\
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;\n\
        proxy_set_header X-Forwarded-Proto http;\n\
    }\n\
}" > /etc/nginx/sites-available/sonarqube

RUN ln -s /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/sonarqube

# Expose the necessary ports
EXPOSE 80 9000 9001

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/

# Set the appropriate permissions for the entrypoint script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Define the default command to start both SonarQube and Nginx
CMD ["/usr/local/bin/entrypoint.sh"]
