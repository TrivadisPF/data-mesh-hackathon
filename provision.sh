#!/bin/sh

echo "copy Oracle DB scripts for Customer domain"
cp -rv ./implementation/customer/oracle/*.sh $DATAPLATFORM_HOME/init/oracle-xe
cp -rv ./implementation/customer/oracle/*.sql $DATAPLATFORM_HOME/init/oracle-xe

echo "copy Oracle DB scripts for Product domain"
#cp -rv ./implementation/product/postgresql/*.sh $DATAPLATFORM_HOME/init/postgresql
cp -rv ./implementation/product/postgresql/*.sql $DATAPLATFORM_HOME/init/postgresql

echo "copy Postgresql scripts for Sales Order domain"
#cp -rv ./implementation/salesorder/postgresql/*.sh $DATAPLATFORM_HOME/init/postgresql
cp -rv ./implementation/salesorder/postgresql/*.sql $DATAPLATFORM_HOME/init/postgresql

echo "copy streamsets properties file"
cp -rv ./implementation/infra/streamsets/configuration.properties $DATAPLATFORM_HOME/custom-conf/streamsets

echo "copy streamsets dev simulator"
cp -rv ./implementation/infra/streamsets/dev-simulator $DATAPLATFORM_HOME/plugins/streamsets/user-libs

echo "copy streamsets jdbc driver"
cp -rv ./implementation/infra/streamsets/streamsets-datacollector-jdbc-lib/*.jar $DATAPLATFORM_HOME/plugins/streamsets/libs-extras/streamsets-datacollector-jdbc-lib/

echo "copy jikkou properties file"
cp -rv ./implementation/infra/jikkou/ecommerce-topic-specs.yml $DATAPLATFORM_HOME/scripts/jikkou

echo "copy ref data"
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/ref
cp -rv ./simulator/ref/data/* $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/ref

echo "copy customer data"
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer
cp -rv ./simulator/customer/data/* $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/customer

echo "copy product data"
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/product
cp -rv ./simulator/product/data/* $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/product

echo "copy salesorder data"
rm -fR $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/salesorder
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator
unzip ./simulator/salesorder/salesorder-data.zip -d $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator
mv $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/data $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/salesorder
rm -fR $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/simulator/__MACOSX/

echo "copy docker-compose.override file"
cp -v ./implementation/infra/docker-compose.override.yml $DATAPLATFORM_HOME

echo "downloading addidional NiFi NARs"
wget https://repo1.maven.org/maven2/org/apache/nifi/nifi-iceberg-processors-nar/1.23.2/nifi-iceberg-processors-nar-1.23.2.nar
wget https://repo1.maven.org/maven2/org/apache/nifi/nifi-iceberg-services-nar/1.23.2/nifi-iceberg-services-nar-1.23.2.nar
wget https://repo1.maven.org/maven2/org/apache/nifi/nifi-iceberg-services-api-nar/1.23.2/nifi-iceberg-services-api-nar-1.23.2.nar

cp -rv *.nar $DATAPLATFORM_HOME/plugins/nifi/nars/
rm *.nar

echo "deploy datahub metadata to have it ready for ingestion"
mkdir -p $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/datahub
cp -v ./implementation/datahub/glossary/*.yml $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/datahub
cp -v ./implementation/datahub/kafka/*.yml $DATAPLATFORM_HOME/data-transfer/data-mesh-poc/datahub

