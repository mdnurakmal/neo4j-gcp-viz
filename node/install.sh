#!/bin/bash

wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz -O neo4j-community-4.4.3-unix.tar.gz
tar xf neo4j-community-4.4.3-unix.tar.gz
apk add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
java -version

ls
sed -i '/dbms.default_listen_address=0.0.0.0/s/^#//g' ./neo4j-community-4.4.3/conf/neo4j.conf 

#./neo4j-community-4.4.3/bin/neo4j console
