#!/bin/bash

wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz -O neo4j-community-4.4.3-unix.tar.gz
tar xf neo4j-community-4.4.3-unix.tar.gz
apk add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
java -version
ls
pwd
./neo4j-community-4.4.3/bin/neo4j console
