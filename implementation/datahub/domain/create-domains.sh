#!/bin/bash

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"ecommerce\", name: \"E-Commerce\", description: \"THe E-Commerce Parent domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"shop\", name: \"Shop\", description: \"Entities related to the shop department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"sasleorder\", name: \"SaleOrder\", description: \"Entities related to the sales order department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customer\", name: \"Customer\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"product\", name: \"Product\", description: \"Entities related to the Product domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customerinteraction\", name: \"Customer Interaction\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"curnDetection\", name: \"Churn Detection\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"recommendation\", name: \"Recommediation\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"reference\", name: \"Reference\", description: \"Entities related to the reference department.\" }) }", "variables":{}}'

