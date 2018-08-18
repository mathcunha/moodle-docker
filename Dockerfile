############################################################
# Dockerfile to install moodle 3.5.1
# Based on debian image
############################################################

FROM debian:9

# Environment variables
ENV PHP_INI=/etc/php/7.0/apache2/php.ini

RUN echo '#!/bin/bash' > /usr/local/bin/configure-moodle.sh

#Proxy settings
#RUN echo 'export http_proxy=http://10.0.2.2:3128' >> /usr/local/bin/configure-moodle.sh
#RUN echo 'export https_proxy=http://10.0.2.2:3128' >> /usr/local/bin/configure-moodle.sh

#setting up apache
RUN echo 'apt-get update' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get install -y php7.0-curl php7.0-mysql libapache2-mod-php7.0 mysql-client php7.0-gd php7.0-intl php7.0-xml php7.0-xmlrpc php7.0-soap php7.0-zip php7.0-mbstring zip' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get autoremove -y' >> /usr/local/bin/configure-moodle.sh
RUN echo 'apt-get clean' >> /usr/local/bin/configure-moodle.sh
RUN chmod 777 /usr/local/bin/configure-moodle.sh
RUN cat /usr/local/bin/configure-moodle.sh
RUN /usr/local/bin/configure-moodle.sh

# php.ini configs
RUN sed -i "s/short_open_tag = .*/short_open_tag = On/" $PHP_INI && \
    sed -i "s/memory_limit = .*/memory_limit = 256M/" $PHP_INI && \
    sed -i "s/display_errors = .*/display_errors = Off/" $PHP_INI && \
    sed -i "s/display_startup_errors = .*/display_startup_errors = Off/" $PHP_INI && \
    sed -i "s/post_max_size = .*/post_max_size = 256M/" $PHP_INI && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" $PHP_INI && \
    sed -i "s/max_file_uploads = .*/max_file_uploads = 10/" $PHP_INI && \
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/" $PHP_INI

#copying moodle
ADD moodle-3.5.1.tgz /var/www/html
RUN chown -R root.www-data /var/www/html/moodle
RUN chmod 777 /var/www/html/moodle
RUN mkdir /var/www/moodledata
RUN chown -R root.www-data /var/www/moodledata
RUN chmod 777 /var/www/moodledata

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

MAINTAINER @mathcunha