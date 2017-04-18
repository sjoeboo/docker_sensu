FROM ubuntu:xenial

RUN apt-get update && apt-get install -y curl apt-transport-https
RUN curl -s https://sensu.global.ssl.fastly.net/apt/pubkey.gpg | apt-key add -
RUN echo "deb     https://sensu.global.ssl.fastly.net/apt xenial main" | tee /etc/apt/sources.list.d/sensu.list
RUN apt-get update && apt-get install -y sensu build-essential && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/sensu/user_conf.d/
COPY conf.d/*.json /etc/sensu/conf.d/
RUN echo "EMBEDDED_RUBY=true" >> /etc/default/sensu

COPY run.sh /root/run.sh

ENV SENSU_TYPE client
ENV SENSU_EXTENSIONS ""
ENV SENSU_PLUGINS ""
ENV SENSU_CLIENT_SUBSCRIPTIONS default

RUN sensu-install -P "sensu-plugins-network-checks,sensu-plugins-disk-checks,sensu-plugins-http,sensu-plugins-memory-checks,sensu-plugins-sensu,sensu-plugins-dns,sensu-plugins-cpu-checks,sensu-plugins-process-checks,sensu-plugins-docker,sensu-plugins-load-checks,sensu-plugins-graphite"
RUN sensu-install -e sensu-extensions-system-profile

CMD /root/run.sh
