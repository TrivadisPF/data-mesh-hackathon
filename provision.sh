#!/bin/sh

# Export the variable with the password for the unzip
# export ZIP_PASSWORD=xxxxx

#mkdir -p docker

#cd docker

#cp ../platys-platform/config.yml .

#platys gen


# copy streamsets properties file
cp -r ./source/infra/streamsets/configuration.properties $DATAPLATFORM_HOME/custom-conf/streamsets


# copy customer data
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer
cp -r ./simulator/customer/data/* $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer



# copy docker-compose.override file
cp  ./source/docker/docker-compose.override.yml $DATAPLATFORM_HOME

