FROM java:7-jre

ENV MFI_VERSION=2.1.11

RUN apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive \
		apt-get install -y -q --no-install-recommends mongodb-server unzip

ADD https://www.ubnt.com/downloads/mfi/$MFI_VERSION/mFi.unix.zip /

RUN unzip mFi.unix.zip && rm mFi.unix.zip

RUN mkdir -p /mFi/logs && ln -s /dev/stderr /mFi/logs/mongod.log && ln -s /dev/stderr /mFi/logs/server.log

EXPOSE 6843/tcp 6080/tcp 6880/tcp 6443/tcp 2323/tcp
EXPOSE 10001/udp 3478/udp 1900/udp

VOLUME ["/mFi/data"]

WORKDIR /mFi

CMD ["java", "-jar", "lib/ace.jar", "start"]
