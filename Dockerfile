FROM debian:jessie

MAINTAINER tiago4859 <tiago4859@gmail.com>

RUN apt-get update && apt-get install -y git make libjansson-dev libbsd-dev libedit2 libedit-dev curl vim wget uuid-dev build-essential \
libxml2-dev libncurses5-dev libsqlite3-dev libssl-dev libxslt-dev libjansson-dev \
libmyodbc unixodbc-bin unixODBC unixODBC-dev libmyodbc unixodbc-bin unixODBC unixODBC-dev

RUN cd /usr/src && wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz \
&& tar -xvf asterisk-18-current.tar.gz

RUN cd /usr/src/ && git clone https://github.com/tiago4859/asterisk.git

RUN cd /usr/src/asterisk-18*/ && \
./configure --with-jansson-bundled && make install && make config && make samples

RUN cd /usr/src/asterisk && tar -xzf asterisk.tar.gz -C /etc/ 

COPY /usr/src/asterisk/pt_BR /var/lib/asterisk/sounds/

RUN rm -rf /usr/src/asterisk-18-current.tar.gz

EXPOSE 4569/udp
EXPOSE 5004-5080/udp
EXPOSE 10000-20000/udp

VOLUME /var/lib/asterisk
VOLUME /var/log/asterisk
VOLUME /var/spool/asterisk
VOLUME /etc/asterisk

CMD ["/usr/sbin/asterisk","-f"]
