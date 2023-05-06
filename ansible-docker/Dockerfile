FROM ubuntu:latest 
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && \
    apt-get install -y gcc vim python2.7-dev libkrb5-dev iputils-ping && \
    apt-get install python3-pip -y && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    pip3 install pywinrm[kerberos] && \
    apt install krb5-user -y && \
    pip3 install pywinrm && \
    pip3 install ansible && \
    apt install -y openssh-client && \
    apt install -y openssh-server && \
    apt install -y sshpass 

