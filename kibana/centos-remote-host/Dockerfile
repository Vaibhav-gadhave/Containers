FROM rockylinux:9.3

RUN dnf install -y epel-release \
    && dnf install -y openssh-server openssh-clients sudo telnet vim net-tools iputils \
    && dnf clean all

RUN mkdir -p /var/run/sshd \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' \
    && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && /bin/echo 'root:1'|chpasswd \
    && useradd vaibhavg \
    && /bin/echo 'vaibhavg:1'|chpasswd \
    && /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd \
    && /bin/echo -e "LANG=\"en_US.UTF-8\"">/etc/default/locale

WORKDIR /data

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]