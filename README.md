# neo4j-gcp-viz

```
wget https://neo4j.com/artifact.php?name=neo4j-community-4.4.3-unix.tar.gz
tar xf
sudo apt update -y
java -version

sudo apt install default-jre -y
sudo apt install openjdk-11-jre-headless -y
sudo apt install openjdk-8-jre-headless -y
```


# To accept non-local connections, uncomment this line:
dbms.default_listen_address=0.0.0.0

Default login is username 'neo4j' and password 'neo4j

# Enable cloud assets api
Export cloud resources to txt
```
 gcloud asset search-all-resources \
    --scope projects/elegant-gearing-339516 \
	> test.txt
```

# Notes

Select all in neo4j
```
Match (n)
Return n
```

Delete all
```
MATCH (n)
DETACH DELETE n
```