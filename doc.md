# Introduction
HBase is a type of ***"NoSQL" distributed*** database. "NoSQL" is a general term meaning that the database isn’t an RDBMS which supports SQL as its primary access language.

HBase internally puts your data in indexed "StoreFiles" that exist on HDFS for high-speed lookups.

HBase features of note are:

    Strongly consistent reads/writes: HBase is not an "eventually consistent" DataStore. This makes it very suitable for tasks such as high-speed counter aggregation.

    Automatic sharding: HBase tables are distributed on the cluster via regions, and regions are automatically split and re-distributed as your data grows.

    Automatic RegionServer failover

    Hadoop/HDFS Integration: HBase supports HDFS out of the box as its distributed file system.

    MapReduce: HBase supports massively parallelized processing via MapReduce for using HBase as both source and sink.

    Java Client API: HBase supports an easy to use Java API for programmatic access.

    Thrift/REST API: HBase also supports Thrift and REST for non-Java front-ends.

    Block Cache and Bloom Filters: HBase supports a Block Cache and Bloom Filters for high volume query optimization.

    Operational Management: HBase provides build-in web-pages for operational insight as well as JMX metrics.



# Execution Mode

## Standalone

### Standalone HBase without HDFS

### Standalone HBase over HDFS

## Distributed

### Pseudo-Distributed Local :
  Pseudo-distributed mode means that HBase still runs completely on a single host, but each HBase daemon (HMaster, HRegionServer, and ZooKeeper) runs as a separate process: in standalone mode all daemons ran in one jvm process/instance.

  By default, unless you configure the hbase.rootdir property as described in quickstart, your data is still stored in /tmp/. 
  
  we store the data in HDFS , assuming HDFS is available, or we can skip the HDFS configuration to continue storing your data in the local filesystem.

### Fully-distributed :
  

# Data Model

	Conceptual View
	Physical View
	Namespace
	Table : An HBase table consists of multiple rows.
	Row
	Column Family
	Cells
	Data Model Operations
	Versions
	Sort Order
	Column Metadata
	Joins
	ACID





# Basic shell commands


Create a table
	create 'test', 'cf'
 
 
List Information About your Table
	list 'test'

	
See details, including configuration defaults
	describe 'test'

	
Put data into your table
	put 'test', 'row1', 'cf:a', 'value1'
	put 'test', 'row2', 'cf:b', 'value2'
	put 'test', 'row3', 'cf:c', 'value3'

	
Scan the table for all data at once.
	scan 'test'

	
Get a single row of data
	get 'test', 'row1'

	
Disable a table
	disable 'test'

	
Enable a table
	enable 'test'
	
Drop the table.
	drop 'test'



	
# TIPS

## Table Schema Rules Of Thumb

There are many different data sets, with different access patterns and service-level expectations. Therefore, these rules of thumb are only an overview. Read the rest of this chapter to get more details after you have gone through this list.

    Aim to have regions sized between 10 and 50 GB.

    Aim to have cells no larger than 10 MB, or 50 MB if you use mob. Otherwise, consider storing your cell data in HDFS and store a pointer to the data in HBase.

    A typical schema has between 1 and 3 column families per table. HBase tables should not be designed to mimic RDBMS tables.

    Around 50-100 regions is a good number for a table with 1 or 2 column families. Remember that a region is a contiguous segment of a column family.

    Keep your column family names as short as possible. The column family names are stored for every value (ignoring prefix encoding). They should not be self-documenting and descriptive like in a typical RDBMS.

    If you are storing time-based machine data or logging information, and the row key is based on device ID or service ID plus time, you can end up with a pattern where older data regions never have additional writes beyond a certain age. In this type of situation, you end up with a small number of active regions and a large number of older regions which have no new writes. For these situations, you can tolerate a larger number of regions because your resource consumption is driven by the active regions only.

    If only one column family is busy with writes, only that column family accomulates memory. Be aware of write patterns when allocating resources.










# External Sources



[Apache HBase - Just the Basics](https://www.youtube.com/watch?v=2Ci_QxJ1kiE)


[IBM Big Data - HBase Fundamentals]( https://www.youtube.com/watch?v=oBalV1lY3pY )

[HBase Schema Design - Things you need to know]( https://www.youtube.com/watch?v=_HLoH_PgrLk )

https://www.youtube.com/watch?v=KZps2dzr_u4