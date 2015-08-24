# Install Nginx & Processwire
#
# VERSION 0.0.1

FROM ubuntu:14.04

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initct

# Install dependencies for nginx installation
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get -y upgrade
# Install dependencies
RUN apt-get install -y nginx php5-fpm php5-mysql pwgen python-setuptools curl openssh-server git unzip php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl
# Supervisor installation
RUN easy_install supervisor
# Add supervisord.conf to image
ADD ./supervisord.conf /etc/supervisord.conf
# Nginx settings
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 3m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
# nginx site config
ADD ./nginx-site.conf /etc/nginx/sites-available/default
# Install Processwire
RUN git clone https://github.com/ryancramerdesign/ProcessWire ./processwire
RUN rm -rf /usr/share/nginx/www 
RUN mv ./processwire/ /usr/share/nginx/www/
RUN mv /usr/share/nginx/www/site-default /usr/share/nginx/www/site
RUN chown -R www-data:www-data /usr/share/nginx/www
# Add start.sh script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
# Open port 80 on container
EXPOSE 80
EXPOSE 22
# Run config script
CMD ["/bin/bash","/start.sh"]
