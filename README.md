# kafka-docker

Dockerfile and docker-compose file for Apache Kafka

## Pre-Requisites
* Install docker-compose
* Build docker image for ZooKeeper (https://github.com/kazono-paypay/zookeeper-docker)

## Build Docker image
```:bash
docker build -t kazono/kafka:2.8.1 .
```
If you want to build specific version, please specify it using `--build-arg`.
```:bash
# Build Kafka v2.7.0 image
docker build -t kazono/kafka:2.7.0 --build-arg kafka_version=2.7.0 .
```

## Usage
Start a cluster.
```:bash
# Create a kafka cluster which has 1 zookeeper and 1 broker
docker-compose up -d zookeeper kafka
```

Add new Broker to existing Kafka Cluster.
```:bash
# Add 1 broker to cluster
docker-compose up -d --scale kafka_scale_out=1 kafka_scale_out
```

Destroy Cluster.
```:bash
docker-compose down
```
