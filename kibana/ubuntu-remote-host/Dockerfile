FROM ubuntu:latest

RUN apt update \
    && apt install -y openssh-server openssh-client sudo telnet vim net-tools iputils-ping

RUN mkdir /var/run/sshd \
    && /bin/echo 'root:1'|chpasswd \
    && useradd vaibhavg \
    && /bin/echo 'vaibhavg:1'|chpasswd \
    && /bin/sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && /bin/sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 

ENV NOTVISIBLE "in users profile" 

RUN echo "export VISIBLE=now" » /etc/profile 

EXPOSE 22 

CMD ["/usr/sbin/sshd", "-D"]

WORKDIR /data

EXPOSE 22
CMD /usr/sbin/sshd -D