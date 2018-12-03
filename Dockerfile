FROM java:openjdk-8-jre 
MAINTAINER sk


ENV HBASE_VERSION 2.1.0 


# install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y python-software-properties curl



# install hbase master
RUN mkdir /opt/hbase
RUN wget -q http://mirrors.gigenet.com/apache/hbase/"$HBASE_VERSION"/hbase-"$HBASE_VERSION"-bin.tar.gz -O /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz
RUN cd /opt/hbase && tar xfvz hbase-"$HBASE_VERSION"-bin.tar.gz
ADD hbase-site.xml /etc/hbase/conf/hbase-site.xml

# need this for hbase to run
ENV JAVA_HOME /usr

# zookeeper
EXPOSE 2181
# HBase Master API port
EXPOSE 60000
# HBase Master Web UI
EXPOSE 60010
# Regionserver API port
EXPOSE 60020
# HBase Regionserver web UI
EXPOSE 60030

CMD /opt/hbase/hbase-"$HBASE_VERSION"/bin/hbase master start