############################################################
# Dockerfile to install moodle 3.3.x
# Based on httpd Image
############################################################

FROM httpd:2.4

#setting up apache
RUN echo '#!/bin/bash' > /usr/local/bin/configure-moodle.sh
RUN echo 'export http_proxy=http://10.0.2.2:3128' >> /usr/local/bin/configure-moodle.sh
RUN echo 'export https_proxy=http://10.0.2.2:3128' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get update' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get install -y php5-curl php5-mysql libapache2-mod-php5 mysql-client php5-gd zip' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get clean' >> /usr/local/bin/configure-moodle.sh
RUN chmod 777 /usr/local/bin/configure-moodle.sh
RUN cat /usr/local/bin/configure-moodle.sh
RUN /usr/local/bin/configure-moodle.sh

#coping moodle
COPY moodle-3.3.7.zip /usr/local/apache2/htdocs/

MAINTAINER @mathcunha
