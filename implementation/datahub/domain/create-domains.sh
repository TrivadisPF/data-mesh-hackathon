#!/bin/bash

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"ecommerce\", name: \"E-Commerce\", description: \"The E-Commerce Parent domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"shop\", parentDomain: \"ecommerce\", name: \"Shop\", description: \"Entities related to the shop department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"sasleorder\", parentDomain: \"ecommerce\", name: \"SaleOrder\", description: \"Entities related to the sales order department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customer\", parentDomain: \"ecommerce\", name: \"Customer\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"product\", parentDomain: \"ecommerce\", name: \"Product\", description: \"Entities related to the Product domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customerinteraction\", parentDomain: \"ecommerce\", name: \"Customer Interaction\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"curnDetection\", parentDomain: \"ecommerce\", name: \"Churn Detection\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"recommendation\", parentDomain: \"ecommerce\", name: \"Recommediation\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"reference\", parentDomain: \"ecommerce\", name: \"Reference\", description: \"Entities related to the reference department.\" }) }", "variables":{}}'

