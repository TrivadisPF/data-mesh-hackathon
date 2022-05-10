#!/bin/sh

# Export the variable with the password for the unzip
# export ZIP_PASSWORD=xxxxx

#mkdir -p docker

#cd docker

#cp ../platys-platform/config.yml .

#platys gen


# copy Oracle DB scripts for Customer domain
cp -r ./implementation/customer/oracle/*.sh $DATAPLATFORM_HOME/init/oraclexe
cp -r ./implementation/customer/oracle/*.sql $DATAPLATFORM_HOME/init/oraclexe

# copy Postgresql scripts for Sales Order domain
cp -r ./implementation/salesorder/postgresql/*.sh $DATAPLATFORM_HOME/init/postgresql
cp -r ./implementation/salesorder/postgresql/*.sql $DATAPLATFORM_HOME/init/postgresql


# copy streamsets properties file
cp -r ./implementation/infra/streamsets/configuration.properties $DATAPLATFORM_HOME/custom-conf/streamsets


# copy customer data
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer
cp -r ./simulator/customer/data/* $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer

# copy salesorder data
rm -R $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/salesorder
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator
unzip ./simulator/salesorder/salesorder-data.zip -d $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator
mv $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/data $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/salesorder
rm -R $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/__MACOSX/

# copy docker-compose.override file
cp  ./implementation/infra/docker-compose.override.yml $DATAPLATFORM_HOME


