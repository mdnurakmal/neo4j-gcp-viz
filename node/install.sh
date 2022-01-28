#!/bin/bash

wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz
tar xf neo4j-community-4.4.3-unix.tar.gz
apt update -y

apt install default-jre -y
apt install openjdk-11-jre-headless -y
apt install openjdk-8-jre-headless -y

java -version

$HOME/neo4j-community-4.4.3/bin/neo4j console
