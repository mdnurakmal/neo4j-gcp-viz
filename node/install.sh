#!/bin/bash

wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz -O neo4j-community-4.4.3-unix.tar.gz
tar xf neo4j-community-4.4.3-unix.tar.gz
apt-get update -y

apt-get install default-jre -y
apt-get install openjdk-11-jre-headless -y
apt-get install openjdk-8-jre-headless -y

java -version
ls
pwd
./neo4j-community-4.4.3/bin/neo4j console
