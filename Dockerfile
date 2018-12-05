FROM java:openjdk-8-jre 
MAINTAINER sk


ENV HBASE_VERSION 2.1.1
ENV HBASE_HOME /opt/hbase/hbase

# install add-apt-repository
RUN \
  apt-get update && \
  apt-get install -y supervisor curl wget vim-tiny



# install hbase master
RUN mkdir -p /opt/hbase/log $HBASE_HOME

RUN wget -q http://apache.mirrors.pair.com/hbase/"$HBASE_VERSION"/hbase-"$HBASE_VERSION"-bin.tar.gz -O /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz

RUN tar -xvzf /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz -C $HBASE_HOME --strip-components=1

#RUN rm /opt/hbase/hbase-"$HBASE_VERSION"-bin.tar.gz

#You need to specify the directory on the local filesystem where HBase and ZooKeeper write data and acknowledge some risks. 

ADD scripts/hbase-site.xml /etc/hbase/conf/hbase-site.xml

ADD scripts/start-hbase.sh /usr/bin/start-hbase.sh

RUN chmod 777 /usr/bin/start-hbase.sh

# Supervisor config 

ADD supervisor/hbase.conf /etc/supervisor/conf.d/

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

# forward request and error logs to docker log collector
# Path of log file being from hbase.conf of supervisor

RUN ln -sf /dev/stdout /opt/hbase/log/hbase.out.log \
&& ln -sf /dev/stderr /opt/hbase/log/hbase.err.log

CMD ["supervisord", "-n"]
#CMD "$HBASE_HOME"/bin/hbase master start