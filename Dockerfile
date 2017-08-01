# Use an official Debian 9 stable as a parent image
FROM debian:stretch

# Make port 80 available to the world outside this container
EXPOSE 80

RUN echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y vim gcc cmake git libssl-dev libev-dev pkg-config systemd-sysv zlib1g-dev libsqlite3-dev
RUN apt-get -t stretch-backports install libuv1-dev

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src/
RUN git clone https://github.com/warmcat/libwebsockets.git libwebsockets
WORKDIR /usr/local/src/libwebsockets
RUN mkdir build
WORKDIR /usr/local/src/libwebsockets/build

RUN cmake .. -DLWS_WITH_LWSWS=1 -DLWS_WITH_GENERIC_SESSIONS=1
RUN make && make install
# install libs in /usr/local/lib ; configured in /etc/ld.so.conf.d/libc.conf
# ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}
RUN ldconfig -v 

RUN mkdir /etc/lwsws
RUN mkdir /etc/lwsws/conf.d
RUN mkdir /var/log/lwsws
RUN mkdir /usr/local/lib/systemd

# Copy the some configs
ADD ./lwsws_conf /etc/lwsws/conf
ADD ./lwsws_my_vhost /etc/lwsws/conf.d/my_vhost
ADD ./lwsws_systemd.service /usr/local/lib/systemd/lwsws.service
ADD ./lwsws_logrotate /etc/logrotate.d/lwsws
ADD ./check.html /usr/local/share/libwebsockets-test-server/check.html
# RUN systemctl enable /usr/local/lib/systemd/lwsws.service
# RUN systemctl start lwsws.service

# Run webserver when the container launches
CMD ["lwsws", ""]

