FROM  openjdk:8u242-jdk AS base

LABEL MAINTAINER="edp_support@groups.163.com"

ARG DAVINCI_ZIP=davinci-assembly_3.0.1-0.3.1-SNAPSHOT-dist-beta.9.zip

RUN cd / \
	&& mkdir -p /opt/davinci \
	&& wget https://github.com/edp963/davinci/releases/download/v0.3.0-beta.9/$DAVINCI_ZIP \
	&& unzip $DAVINCI_ZIP -d /opt/davinci\
	&& rm -rf $DAVINCI_ZIP \
	&& cp -v /opt/davinci/config/application.yml.example /opt/davinci/config/application.yml

RUN mkdir -p /opt/phantomjs-2.1.1 \
    && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& unzip phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& rm -rf phantomjs-2.1.1-linux-x86_64.tar.bz2 \
	&& mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /opt/phantomjs-2.1.1/phantomjs \
	&& rm -rf phantomjs-2.1.1-linux-x86_64


ADD bin/docker-entrypoint.sh /opt/davinci/bin/docker-entrypoint.sh


RUN chmod +x /opt/davinci/bin/docker-entrypoint.sh \
&&  chmod +x /opt/phantomjs-2.1.1/phantomjs


ENV DAVINCI3_HOME /opt/davinci
ENV PHANTOMJS_HOME /opt/phantomjs-2.1.1
ENV OPENSSL_CONF=/etc/ssl/

WORKDIR /opt/davinci

CMD ["./bin/start-server.sh"]

EXPOSE 8080