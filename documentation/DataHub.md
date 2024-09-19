# Working with DataHub

```bash
export DATAPLATFORM_IP=${DOCKER_HOST_IP}
export DATAHUB_GMS_URL=http://$DATAPLATFORM_IP:28142
```

## Deleting artefacts

### Delete by Platform

Delete all Kafka metadata

```bash
datahub delete --platform kafka
```

### Delete by Entity Type

Delete all datasets

```bash
datahub delete --entity-type dataset
```

Delete all domains

```bash
datahub delete --entity-type domain
```

Delete all data products

```bash
datahub delete --entity-type data_product
```

Delete all business glossaries

```bash
datahub delete --entity-type glossary_term
datahub delete --entity-type glossary_node
```

You can find the different entity types here: <https://datahubproject.io/docs/graphql/enums/#entitytype>.


