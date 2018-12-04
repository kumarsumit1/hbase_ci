FROM java:openjdk-8-jre 
MAINTAINER sk


ENV HBASE_VERSION 2.1.1
ENV HBASE_HOME /opt/hbase/hbase-"$HBASE_VERSION" 

# install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y supervisor curl wget vim-tiny



# install hbase master
RUN mkdir /opt/hbase

RUN wget -q http://apache.mirrors.pair.com/hbase/"$HBASE_VERSION"/hbase-"$HBASE_VERSION"-bin.tar.gz -O /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz

RUN cd /opt/hbase && tar xfvz hbase-"$HBASE_VERSION"-bin.tar.gz

RUN rm /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz

#You need to specify the directory on the local filesystem where HBase and ZooKeeper write data and acknowledge some risks. 

ADD scripts/hbase-site.xml /etc/hbase/conf/hbase-site.xml

ADD scripts/start-hbase.sh /usr/bin/start-hbase.sh

RUN chmod 777 /usr/bin/start-hbase.sh

# Supervisor config 

#ADD supervisor/hbase.conf /etc/supervisor/conf.d/

#Most modern Linux operating systems provide a mechanism, such as /usr/bin/alternatives on RHEL or CentOS,
# for transparently switching between versions of executables such as Java. 
#In this case, you can set JAVA_HOME to the directory containing the symbolic link to bin/java, 
#which is usually /usr

# You are required to set the JAVA_HOME environment variable before starting HBase

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

#  Go to http://localhost:16010 to view the HBase Web UI.
EXPOSE 16010

# REST API's
EXPOSE 8080


#CMD ["supervisord", "-n"]
CMD "$HBASE_HOME"/bin/hbase master start