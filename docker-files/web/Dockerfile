FROM obisconcept/docker-web:1.0.0
MAINTAINER dev@obis-concept.de

ENV NEOS_REPO="https://github.com/obisconcept/neos-demo-distribution.git"
ENV NEOS_SITE="ObisConcept.NeosDemo"

COPY ./container-files /
RUN chmod +x /config/*.sh
RUN chmod +x /config/init/*.sh