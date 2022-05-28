# Setup Showcase

First clone the GitHub Project

```bash
git clone http://github.com/trivadispf/data-mesh-hackathon
```

Navigate to the project folder

```bash
cd data-mesh-hackathon
```

Set the `DATAPLATFORM_HOME` environment variable to the `infra/platys` folder.

```bash
export DATAPLATFORM_HOME=${PWD}/infra/platys
```

Run the provision script to copy the data into the platys platform folder

```
./provision.sh
```

Start the platys platform

```
export PUBLIC_IP=xxxx
export DOCKER_HOST_IP=xxx

cd ./infra/platys
docker-compose up -d
```

wait for the platform to start

```
...
Creating hive-metastore-db          ... done
Creating zeppelin                   ... done
Creating kafka-connect-1            ... done
Creating akhq                       ... done
Creating file-browser               ... done
Creating kafka-1                    ... done
Creating kafka-3                    ... done
Creating kafka-2                    ... done
Creating ksqldb-cli                 ... done
Creating spark-worker-1             ... done
Creating spark-worker-2             ... done
docker@ubuntu ~/d/i/platys (main)>
```

Once the platform is started sucessfully, we can deploy the various artefacts. 

The Kafka topics have been automatically created by `jikkou`. 

To deploy the the Avro schemas to the schema registry, perform

```bash
export DATAPLATFORM_IP=${DOCKER_HOST_IP}

cd $DATAPLATFORM_HOME/../../implementation/global/java/ecommerce-meta/
mvn clean install schema-registry:register

cd $DATAPLATFORM_HOME/../../implementation/salesorder/java/ecommerce-salesorder-meta/
mvn clean install schema-registry:register
```

To deploy the streamsets pipelines, perform

```bash
cd $DATAPLATFORM/
```


