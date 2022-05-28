#!/bin/bash

if [ -z "$1" ]
  then
    echo 'Please specify the home directory of the Data Mesh project!'
    exit 1
fi

echo "Waiting for Streamsets to start listening on connect..."

while [ $(curl -s -o /dev/null -w %{http_code} --insecure http://localhost:8083 -ne 200 ] ; do
  echo -e $(date) " Streamsets state: " $(curl -s -o /dev/null -w %{http_code} --insecure http://localhost:8083) " (waiting for 200)"
  sleep 5
done

nc -vz localhost 8083

echo -e "\n--\n+> Creating Kafka Connect Connectors"

$1/implementation/salesorder/kafka-connect/start-connect-jdbc.sh
