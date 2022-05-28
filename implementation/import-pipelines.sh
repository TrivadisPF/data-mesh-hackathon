#!/bin/bash

if [ -z "$1" ]
  then
    echo 'Please specify the directory which contains the streamsets pipelines!'
    exit 1
fi

echo "Waiting for Streamsets to start listening on connect..."

while [ $(curl -s -o /dev/null -w %{http_code} --insecure https://localhost:18630/rest/v1/pipelines/status) -ne 200 ] ; do
  echo -e $(date) " Streamsets state: " $(curl -s -o /dev/null -w %{http_code} --insecure https://localhost:18630/rest/v1/pipelines/status) " (waiting for 200)"
  sleep 5
done

nc -vz localhost 18630

echo -e "\n--\n+> Creating Streamsets Pipelines"

curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/simulator/customer/streamset/customer_simulate-person-and-address.json" --insecure https://localhost:18630/rest/v1/pipeline/customer_simulate-person-and-address/import?includeLibraryDefinitions=true&rev=0
curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/simulator/customer/streamset/customer_init.json" --insecure https://localhost:18630/rest/v1/pipeline/customer_init/import?includeLibraryDefinitions=true&rev=0

curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/simulator/salesorder/streamset/salesorder_simulate-order-online.json" --insecure https://localhost:18630/rest/v1/pipeline/salesorder_simulate-order-online/import?includeLibraryDefinitions=true&rev=0
curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/simulator/salesorder/streamset/salesorder_init.json" --insecure https://localhost:18630/rest/v1/pipeline/salesorder_init/import?includeLibraryDefinitions=true&rev=0

curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/simulator/salesorder/streamset/ref_init.json" --insecure https://localhost:18630/rest/v1/pipeline/ref_init/import?includeLibraryDefinitions=true&rev=0


curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/implementation/customer/streamset/customer_customeraddresschanged-to-kafka.json" --insecure https://localhost:18630/rest/v1/pipeline/customer_customeraddresschanged-to-kafka/import?includeLibraryDefinitions=true&rev=0
curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/implementation/customer/streamset/customer_customerstate-to-kafka.json" --insecure https://localhost:18630/rest/v1/pipeline/customer_customerstate-to-kafka/import?includeLibraryDefinitions=true&rev=0
curl -XPOST -u admin:admin -H 'Content-Type: application/json' -H 'X-Requested-By: My Import Process' --data @"${1}/implementation/customer/streamset/customer_replicate-country-from-ref.json" --insecure https://localhost:18630/rest/v1/pipeline/customer_replicate-country-from-ref/import?includeLibraryDefinitions=true&rev=0


echo ""
