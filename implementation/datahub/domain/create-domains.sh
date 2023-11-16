#!/bin/bash

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customer\", name: \"Customer\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"product\", name: \"Product\", description: \"Entities related to the Product domain.\" }) }", "variables":{}}'

