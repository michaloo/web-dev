# michaloo/webdev
#
# VERSION               0.0.1

FROM michaloo/node-dev

MAINTAINER Michal Raczka me@michaloo.net

RUN apt-get update -y \
    && apt-get install -y git

RUN apt-get install -y apache2

RUN apt-get install -y php5-cli php5-gd php5-mysql php5-mcrypt libapache2-mod-php5

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN curl -L https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

RUN a2enmod rewrite

EXPOSE 80

ENTRYPOINT [ "/bin/bash" ]

CMD [ "/start.sh" ]

ADD ./start.sh /start.sh
