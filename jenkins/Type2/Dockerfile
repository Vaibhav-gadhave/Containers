FROM jenkins/jenkins:lts

USER root

RUN apt-get update \
    && apt-get -y install curl vim \
    && curl https://get.docker.com/ > /var/jenkins_home/dockerinstall \
    && chmod 777 /var/jenkins_home/dockerinstall \
    && sh /var/jenkins_home/dockerinstall

USER jenkins

