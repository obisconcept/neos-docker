FROM ubuntu:16.04
MAINTAINER dev@obis-concept.de

ENV NEOS_REPO="https://github.com/obisconcept/neos-demo-distribution.git"
ENV NEOS_SITE="ObisConcept.NeosDemo"

COPY ./container-files /
RUN chmod +x /config/*.sh
RUN chmod +x /config/init/*.sh

RUN apt-get update && apt-get install -y openssh-server apache2 supervisor git curl mysql-client
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN apt-get install -y php7.0 php7.0-cli php7.0-common php7.0-curl libapache2-mod-php7.0 php7.0-dev php7.0-gd php7.0-intl php7.0-json php7.0-mysql php7.0-mcrypt php7.0-mbstring php7.0-bcmath php7.0-xml php7.0-soap php7.0-zip php-imagick

EXPOSE 22 80
ENTRYPOINT ["/config/bootstrap.sh"]