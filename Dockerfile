FROM java:7-jre

ENV MFI_VERSION=2.1.11

RUN apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive \
		apt-get install -y -q --no-install-recommends mongodb-server unzip

ADD https://www.ubnt.com/downloads/mfi/$MFI_VERSION/mFi.unix.zip /

RUN unzip mFi.unix.zip && rm mFi.unix.zip

RUN mkdir -p /mFi/logs && ln -s /dev/stderr /mFi/logs/mongod.log && ln -s /dev/stderr /mFi/logs/server.log

EXPOSE 6843 6080 6081 6880 6443 2323

VOLUME ["/mFi/data"]

WORKDIR /mFi

CMD ["java", "-jar", "lib/ace.jar", "start"]
