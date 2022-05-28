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
