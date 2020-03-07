# Kafka Cluster
This is a development cluster confguration for kafka and zookeeper. In a production cluster the kafka storage should be externalized from the container using bind mounts.

## Deploying Cluster

First create the network. This is done outside of the compose files to enable other stacks to connect to the cluster, from inside of the swarm, rather than publishing the ports on the host.
```
docker network create --attachable -d overlay kafka
```

First start the zookeeper cluster using the command below
```
docker stack deploy -c zoo.yml kafka
```

Wait for all of the zookeeper nodes to successfully download and start and then attach to the zoo_test container using the following command from the node in the swarm it is running on.
```
docker exec -it <kafka_zoo_test container name> /bin/sh
```

Once in the contianer you can issue the following commands to check out the zookeeper cluster and its operational state.
```
echo srvr | nc zoo1 2181
echo srvr | nc zoo2 2181
echo srvr | nc zoo3 2181
```

Once the zookeeper cluster is stable use the command below to start the kafka cluster.
```
docker stack deploy -c kafka.yml kafka
```
## Testing the Kafka Cluster
### Create Topic
The following command creates a topic called test.
```
docker run \
  --net=kafka \
  --rm \
  confluentinc/cp-kafka:latest \
  kafka-topics --create --topic test --partitions 6 --replication-factor 3 --if-not-exists --zookeeper zoo1:2181,zoo2:2181,zoo3:2181
```
### Describe Topic

The following command displays the topic patitions and in sync replica states.
```
docker run   --net=kafka \
  --rm   confluentinc/cp-kafka:latest \
    kafka-topics --describe --topic test --zookeeper zoo1:2181
```
### Send Messages to Topic

The following command sends messages to the topic.
```
docker run \
  --net=kafka \
  --rm confluentinc/cp-kafka:latest \
  bash -c "seq 42 | kafka-console-producer --broker-list kafka1:19092,kafka2:19092,kafka3:19092 --topic test && echo 'Produced 42 messages.'"
```
### Read Messages From Topic

Finally the next command reads messages from the topic.
```
docker run \
 --net=kafka \
 --rm \
 confluentinc/cp-kafka:latest \
 kafka-console-consumer --bootstrap-server kafka1:19092,kafka2:19092,kafka3:19092 --topic test --from-beginning
```

