FROM ubuntu

USER root

# Install necessary packages
RUN apt-get update \
    && apt-get -y install net-tools iputils-ping curl vim screen git nano curl screen default-jre-headless openjdk-8-jdk 

# Install Docker
RUN curl -fsSL https://get.docker.com/ | sh

# Create the Jenkins_node1 user
RUN useradd -r jenkins_node1

# Add the Jenkins_node1 user to the docker group
RUN usermod -aG docker jenkins_node1

USER root