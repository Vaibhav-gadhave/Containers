FROM jenkins/jenkins:lts

USER root

# Install Docker
RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://get.docker.com/ > dockerinstall && \
    chmod 777 dockerinstall && \
    ./dockerinstall && \
    rm -rf /var/lib/apt/lists/*

# Set permissions for Docker socket
RUN chmod 666 /var/run/docker.sock

USER jenkins

# Start Jenkins
CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]

