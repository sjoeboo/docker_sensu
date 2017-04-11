FROM ubuntu:xenial

RUN apt-get update && apt-get install -y curl apt-transport-https
RUN curl -s https://sensu.global.ssl.fastly.net/apt/pubkey.gpg | apt-key add -
RUN echo "deb     https://sensu.global.ssl.fastly.net/apt xenial main" | tee /etc/apt/sources.list.d/sensu.list
RUN apt-get update && apt-get install -y sensu

RUN mkdir /etc/sensu/user_conf.d/
COPY conf.d/*.json /etc/sensu/conf.d/
RUN echo "EMBEDDED_RUBY=true" >> /etc/default/sensu

COPY run.sh /root/run.sh

ENV SENSU_TYPE client
ENV SENSU_PLUGINS ""
ENV EXTRA_PLUGINS ""
ENV SENSU_CLIENT_SUBSCRIPTIONS default

ENV SENSU_EXTENSIONS "sensu-extensions-system-profile"


CMD /root/run.sh
