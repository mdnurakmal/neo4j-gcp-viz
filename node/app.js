const neo4j = require('neo4j-driver')
const express = require('express')
const path = require('path');
const app = express()
const port = 8080
// set the view engine to ejs
app.set('view engine', 'ejs');

app.get('/', function(req, res) {

      var tagline = "No programming concept is complete without a cute animal mascot.";
    
      res.render('pages/index', {
        ip_address: ip_address
      });
  });

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

const ip_address = "<PUBLIC_IP>"
const driver = neo4j.driver("bolt://"+ip_address+":7687", neo4j.auth.basic("neo4j", "1234"))

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

    const fileStream = fs.createReadStream(path.join(__dirname, 'db.txt'));

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