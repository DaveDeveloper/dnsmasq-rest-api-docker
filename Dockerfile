FROM php:7.4-alpine

LABEL maintainer "dave@davedeveloper.com"

RUN apk --no-cache add openrc
RUN apk --no-cache add curl
RUN apk --no-cache add dnsmasq
RUN apk --no-cache add git
RUN apk --no-cache add supervisor
RUN apk --no-cache add apache2 php8-apache2
RUN docker-php-ext-install json
RUN docker-php-ext-configure json 

ADD https://raw.githubusercontent.com/DaveDeveloper/dnsmasq-rest-api/php7.1-aplpine-docker/install.sh /opt/dnsmasq-rest-api-install.sh

#COPY install.sh /opt/dnsmasq-rest-api-install.sh

ADD https://raw.githubusercontent.com/DaveDeveloper/dnsmasq-rest-api/php7.1-aplpine-docker/dnsmasq.conf /etc/dnsmasq.conf

#COPY dnsmasq.conf /etc/dnsmasq.conf

RUN chmod +x /opt/dnsmasq-rest-api-install.sh

RUN file="$(ls -1 /opt)" && echo $file

RUN sh -c "/opt/dnsmasq-rest-api-install.sh"

COPY supervisord.conf /etc/supervisord.conf

VOLUME /etc/dnsmasq


CMD ["supervisord", "-c", "/etc/supervisord.conf"]
#CMD ["/etc/init.d/dnsmasq","restart"]
#CMD ["/etc/init.d/apache2", "restart"]

EXPOSE 53 53/udp
EXPOSE 80 80/tcp


#ENTRYPOINT ["dnsmasq", "-k"]
