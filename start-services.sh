#!/bin/bash -e

docker-compose up -d

## upload config
docker exec -it --user solr solr-master bin/solr zk -upconfig -n demo-conf -z zookeeper:2181 -d /opt/solr/server/solr/configsets/sample_techproducts_configs/conf

## create collections
docker exec -it --user solr solr-master bin/solr create -c demo-collection -n demo-conf -s 2 -rf 2
    
## index data
docker exec -it --user solr solr-master bin/post -c demo-collection /opt/solr/example/exampledocs/books.csv

echo "Solr cloud is running on http://localhost:8983 ..."
