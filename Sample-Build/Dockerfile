FROM quay.io/centos/centos:stream9
MAINTAINER ServerWorld <admin@srv.world>

RUN dnf -y install nginx
RUN echo "Nginx on node01" > /usr/share/nginx/html/index.html

EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

