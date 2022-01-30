const neo4j = require('neo4j-driver')
const express = require('express')
const app = express()
const port = 80

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

const driver = neo4j.driver("bolt://localhost:7687", neo4j.auth.basic("neo4j", "neo4j"))

const session = driver.session()

const fs = require('fs');
const readline = require('readline');

const getMapFromArray = data =>
    data.reduce((acc, item) => {

        acc[item.name] = {
            type: item.assetType,
            displayName: item.displayName,
            name: item.name
        };
        return acc;
    }, {});

async function processLineByLine() {

    const fileStream = fs.createReadStream('db.txt');

    const rl = readline.createInterface({
        input: fileStream,
        crlfDelay: Infinity
    });

    var resource = {};
    var resourceGroup = [];
    var startElement = false;
    var projectName = "";

    for await (const line of rl) {
        if (line == "---" && !startElement) {
            startElement = true;
            continue;
        } else if (line == "---" && startElement) {
            startElement = false;
            resourceGroup.push(resource);
            resource = {};
            continue;
        }


        if (startElement) {
            var temp = line.split(":");
            resource[temp[0]] = temp[1];

            if (temp[0] == "project" && projectName == "") {
                projectName = temp[1].split("/")[1];
            }
        }
    }

    var rg = getMapFromArray(resourceGroup);

    await session.run(
        'MERGE (p:Project {name: $name})', {
            name: projectName
        }
    ).catch(function(err) {
        throw err
    });

    for (const key in rg) {
        console.log(key);

        await session.run(
            'MERGE (a:assetType {name: $name})', {
                name: rg[key].type.split("/")[1]
            }
        ).catch(function(err) {
            throw err
        });


        await session.run(
            'MERGE (r:resource {name: $name})', {
                name: rg[key].name
            }
        ).catch(function(err) {
            throw err
        });


        await session.run(
            'MATCH (a:assetType {name: $assetType})  MATCH (r:resource {name: $name}) MERGE (r)-[:IS_A]->(a)', {
                assetType: rg[key].type.split("/")[1],
                name: rg[key].name,
            }
        ).catch(function(err) {
            throw err
        });

        await session.run(
            'MATCH (p:Project {name: $projectName}) MATCH (a:assetType {name: $assetType}) MERGE (a)-[:IS_IN]->(p)', {
                assetType: rg[key].type.split("/")[1],
                name: rg[key].name,
                displayName: rg[key].displayName,
                projectName: projectName
            }
        ).catch(function(err) {
            throw err
        });



    }

    await driver.close()
}

processLineByLine();