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

# copy order data
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/order
unzip ./simulator/order/data.zip
mv .csv $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/order
rm -R __MACOSX/

# copy docker-compose.override file
cp  ./source/infra/docker-compose.override.yml $DATAPLATFORM_HOME


