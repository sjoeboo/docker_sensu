#!/bin/bash

for i in $SENSU_PLUGINS
do
  sensu-install -p $i
done

for i in $EXTRA_PLUGINS
do
  sensu-install -p $i
done

for e in $SENSU_EXTENSIONS
do
  sensu-install -e $e
done



case $SENSU_TYPE in
  "api")
    sensu_command="/opt/sensu/bin/sensu-api"
  ;;
  "server")
    sensu_command="/opt/sensu/bin/sensu-server"
  ;;
  *)
    sensu_command="/opt/sensu/bin/sensu-client"
esac

echo "Running Sensu ${SENSU_TYPE} with ${sensu_command}"

${sensu_command} -d /etc/sensu/conf.d/,/etc/sensu/user_conf.d/ -v
