FROM centos:7

RUN yum install epel-release -y \
    && yum install -y openssh-server openssh-clients sudo telnet vim net-tools software-properties-common \
    && yum clean all

RUN mkdir -p /var/run/sshd \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && /bin/echo 'root:1'|chpasswd \
    && useradd vaibhavg \
    && /bin/echo 'vaibhavg:1'|chpasswd \
    && /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd \
    && /bin/echo -e "LANG=\"en_US.UTF-8\"">/etc/default/local

# Install Ansible only for the "ansible" service
ARG INSTALL_ANSIBLE=true
RUN if [ "$INSTALL_ANSIBLE" = "true" ]; then \
    yum install -y ansible; \
fi

WORKDIR /ansible

EXPOSE 22
CMD /usr/sbin/sshd -D
