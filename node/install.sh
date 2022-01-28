#!/bin/bash

wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz -O neo4j-community-4.4.3-unix.tar.gz
tar xf neo4j-community-4.4.3-unix.tar.gz
apk update

apk add openjdk8=8.242.08-r0 -y

java -version
ls
pwd
./neo4j-community-4.4.3/bin/neo4j console
