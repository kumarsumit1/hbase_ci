# HBase : Standalone with REST

A docker image of [HBase]( https://hbase.apache.org/book.html ) running in standalone mode with [REST interface](https://hbase.apache.org/book.html#_rest) enabled.

## Usage
```
docker run -it --name=hbase \
      -h hbase \
      -p 2181:2181 \
      -p 8080:8080 \
      -p 16000:16000 \
      -p 16010:16010 \
      -p 16020:16020 \
      -p 16030:16030 \
      -v </path/to/hbasedata>:/data/hbase \
      -v </path/to/zookeeperdata>:/data/zookeeper \
      kumarsumit1/hbase_ci
```

#### Parameters
* `-h hbase` Set hostname to hbase (optional)
* `-p 2181` Zookeeper port
* `-p 8080` REST interface port
* `-p 16000` Master port
* `-p 16010` Master info port
* `-p 16020` Regionserver port
* `-p 16030` Regionserver info port
* `-v /data/hbase` HBase persistent data
* `-v /data/zookeeper` Zookeeper persistent data

#### HBase Master server interface
http://hbase:16010/master-status

#### Verifying HBase REST interface
```
# HBase Version
[user@host ~]$ curl http://hbase:8080/version/cluster

# Cluster Status
[user@host ~]$ curl http://hbase:8080/status/cluster

# Table List
[user@host ~]$ curl http://hbase:8080/
```
### Accessing the HBase shell
```
[user@host ~]$ docker exec -it hbase bash
/opt/hbase/hbase-2.1.1/bin/hbase shell
```