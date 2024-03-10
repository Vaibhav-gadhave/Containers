FROM jenkins/jenkins:lts

USER root

# Install necessary packages
RUN apt-get update \
    && apt-get -y install net-tools iputils-ping curl vim screen

# Install Docker
RUN curl -fsSL https://get.docker.com/ | sh

# Add the Jenkins user to the docker group
RUN usermod -aG docker jenkins

USER jenkins