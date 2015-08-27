FROM java:7-jre

ENV MFI_VERSION=2.1.11

RUN apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive \
		apt-get install -y -q --no-install-recommends mongodb-server unzip

ADD https://www.ubnt.com/downloads/mfi/$MFI_VERSION/mFi.unix.zip /

RUN unzip mFi.unix.zip && rm mFi.unix.zip

EXPOSE 6843 6080 6081 6880 6443

VOLUME ["/mFi/data"]

WORKDIR /mFi

CMD ["java", "-jar", "lib/ace.jar", "start"]
