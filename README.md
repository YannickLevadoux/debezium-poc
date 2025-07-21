## Main

This PoC is higly based on [debezium tutorial](https://debezium.io/documentation/reference/stable/tutorial.html) to observe how Debezium actually works. It's design to run on your linux machine for testing only.

References : [debezium-examples - tutorial on github](https://github.com/debezium/debezium-examples/tree/main/tutorial)

My initial use case was this : 

- One postgres server is the database source.
- We plug on it a debezium connector to write event in a kafka cluster.
- One other postgres server is the destination database
- We plug a jdbc sink connector to feed it from kafka

Based on Debezium tutorial, I have added an adminer container to manage the sql query and DB visualisation and a AKHQ instance to see what's going on at kafka & kafka connect level (it also ease the offset management)


## URL & server

AKHQ : [http://localhost:8080/](http://localhost:8080/)

Adminer : [http://localhost:8099](http://localhost:8099)

Kafka Connect : [http://localhost:8083](http://localhost:8083)

Postgres servers :
- postgres : the 'publisher' postgres server, based on debezium tutorial
- pg_sub : the 'subscriber' postgres server, a vanilla postgres container


## How to 

### Start

Run `docker-compose up -d` to start 

### Debezium connector

First think you need to do is to create debezium connector (Connect-debezium-creation.txt)

Then you can observe what going on at kafka level

### Consume the data with jdbc connectors 

After, you need to init db_sub database by creating a schema named inventory : `CREATE SCHEMA inventory;`

Then you can create the jdbc sink connectors. 

All of them have `table.name.format` setting. It's required to write in the table you want (default in the topic name, \<dbname\>.\<schema\>.\<table\>)

All of them also have transforms settings. It's required to avoid debezium metadata to be written in the target DB

Some sql query are ready in the `db_sub.sql`

Connector's creation are in `Connect-jdbc-sink.txt` file

### jdbc-sink-customers 

It's design like this : create the table with an additionnal column 'bitmask' and the function to populate the bitmask column and finally a trigger when you add / update a new row.

Once this is created on target db, create the jdbc-sink-customers (from Connect-jdbc-sink.txt)

### jdbc-sink-orders

this connector is designed to create itself the table on target db

### jdbc-sink-products
 
This connector has a whitelist setting to get only some field in the event.

Create the table according to db_sub.sql (additionnaly create function and trigger if you want to) then you can create jdbc-sink-products connector

you can observe that the field description is avoided in the target table

### Stop and cleanup

Run `docker-compose down` to stop and cleanup

