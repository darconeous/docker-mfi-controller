FROM debian

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get install -y -q --no-install-recommends ca-certificates mongodb-server default-jre-headless

RUN apt-get -y update \
	&& apt-get install -y -q --no-install-recommends wget unzip \
	&& wget https://www.ubnt.com/downloads/mfi/2.1.11/mFi.unix.zip \
	&& unzip mFi.unix.zip \
	&& rm mFi.unix.zip \
	&& apt-get -y --auto-remove purge wget unzip

ADD system.properties /mFi/data/system.properties

EXPOSE 80 443 6080 6443 6081

VOLUME ["/mFi/data"]

RUN apt-get install -y -q --no-install-recommends vim

WORKDIR /mFi
CMD ["java", "-jar", "lib/ace.jar", "start"]
