# Working with DataHub

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

You can find the different entity types here: <https://datahubproject.io/docs/graphql/enums/#entitytype>.


