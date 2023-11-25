#!/bin/bash

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"ecommerce\", name: \"E-Commerce\", description: \"The E-Commerce Parent domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"shop\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Shop\", description: \"Entities related to the shop department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"salesorder\", parentDomain: \"urn:li:domain:ecommerce\", name: \"SalesOrder\", description: \"Entities related to the sales order department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customer\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Customer\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"product\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Product\", description: \"Entities related to the Product domain.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"customerinteraction\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Customer Interaction\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"curnDetection\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Churn Detection\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"recommendation\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Recommediation\", description: \"Entities related to the customer department.\" }) }", "variables":{}}'

curl --location --request POST ${DATAHUB_GMS_URL}/api/graphql \
--header 'Content-Type: application/json' \
--data-raw '{ "query": "mutation createDomain { createDomain(input: { id: \"reference\", parentDomain: \"urn:li:domain:ecommerce\", name: \"Reference\", description: \"Entities related to the reference department.\" }) }", "variables":{}}'

