# Server Side

## Tools
* VSCode
* Node JS
* [Postman](https://www.postman.com/downloads/)
  + For Ubuntu 20.04 installation
    ```
    $ sudo snap install postman
    ```
* Packages
  + mysql : MySql database CRUD
  + express : REST framework
  + body-parser : for parsing html body json content

## Prepare Project
* Create a new project folder

```bash
// init new Node project. create package.json file
$ npm init

// install packages
$ npm install --save mysql
$ npm install --save express body-parser
```

### Quick Fix for MySQL8
* node js packages still do not support new password scheme of MySQL8.
* thus switch to old native scheme for node JS support. (Note :  The native scheme is less secure)
* Update MySql root password to native

```sql
mysql> ALTER USER 'root'@'localhost' 
IDENTIFIED WITH mysql_native_password 
BY 'password';
```

## Accessing database from nodejs

* CRUD operation - CREATE, READ, UPDATE, DELETE (For database operation)
* database.js
```javascript
const mysql = require("mysql");

parameters = {
    host: "localhost",
    user: "root",
    password: "7572137",
    database: "nusbank",
    multipleStatements: true,
};

let connection = mysql.createConnection(parameters);
connection.connect((error) => {
    if (error){
        console.log(error);
    } else {
        console.log("Connection was successfull");
    }
});

connection.query(`SELECT * FROM users LIMIT 5`, (err, result) => {
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

let newuser = { id: 599,
        name: "Harry Lim",
    mail: "harrylim@abc.com",
    mobile: "99887788",
    nric: "S223311A"
};

connection.query(`DELETE FROM users WHERE user_id = ${newuser.id}`, (err, result) =>{
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

connection.query(
    `INSERT INTO users(user_id, name, mail, mobile, nric) 
    VALUES (${newuser.id},'${newuser.name}', '${newuser.mail}', ${newuser.mobile}, '${newuser.nric}')`,
    (err, results) => {
        if (err){
            console.log(err);
        } else {
            if (results["affectedRows"] != 0) {
                console.log("Added", results);
            }
        }        
    });

//
connection.query(`DELETE FROM users WHERE user_id = ${newuser.id}`, (err, result) =>{
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

// query highest monthly transaction
connection.query(`SELECT a.user_id, u.name, a.acct_number, t.date, COUNT(a.user_id) as cmonth
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
INNER JOIN users AS u
ON u.user_id = a.user_id
GROUP BY a.user_id, MONTH(t.date), YEAR(t.date)
ORDER BY cmonth DESC
LIMIT 1`,
(err, results) => {
    if (err){
        console.log(err);
    } else {
        if (results["affectedRows"] != 0) {
            console.log("Highest Montly", results);
        }
    }        
});
```

## API
* Application Programming Interface
* Purpose : contract defining how different systems will communicate
* Styles
  + REST
  + RPC : SOAP (xml format)
  + GraphQL : By Facebook. For databases
  + Event-Driven : For streaming services. Require realtime update.
* REST API to expose data from MySQL

### REST
* http
* POST, GET, PUT, DELETE
* Components
  + URI
  + headers
  + key
  + method

Component | Description
----|-----
API name | 
Description |
Method | GET, POST, PUT, DELETE
URI | Location, port (example:/user/id)
Headers, Parameters, Body |
Authentication & Authorisation | Key, bearer token
Response | Status Code, body

* ExpressJS : Framework for implementing REST server
* apis.js 
```javascript
const express = require('express');
const bodyParser = require('body-parser');

var app = express();

// parse body formatted in JSON
app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.send('Hello Express');
});

app.get('/squared', (req, res) => {
    // JSON format
    // { "number": 2}
    number = req.body.number;
    squared = number * number;

    res.send(`Squared : ${squared}`);

    // from POSTMAN.. set Body raw content as JSON data
    // { "number": 3 }
});

app.listen(process.env.PORT || 3000);

```
* Powershell Environment Variable

```Powershell
// create variable PORT=3001
PS> $Env:PORT = 3001

// return PORT value
PS> $Env:PORT

````


## API & database integration

* server.js

```javascript
const mysql = require("mysql");
const express = require("express");
const bodyParser = require("body-parser");

parameters = {
    host: "localhost",
    user: "root",
    password: "7572137",
    database: "nusbank",
    multipleStatements: true,
};

let connection = mysql.createConnection(parameters);
connection.connect((error) => {
    if (error){
        console.log(error);
    } else {
        console.log("Connection was successfull");
    }
});

/// Connected
let app = express();

app.use(bodyParser.json());

// GET route for /user query
app.get("/user", (request, response) => {
    connection.query("SELECT * FROM users LIMIT 10", (err, result) => {
        if (err) {
            response.send("Some error occur");
        }
        else {
            response.send(result);
        }    
    });
});

// GET route for /user/id query
// with body = { "id": 2 }
app.get("/user/id", (request, response) => {
    console.log(request.body);
    //
    connection.query(`SELECT * FROM users WHERE user_id = ${request.body.id}`, 
    (err, result) => {
        if (err) {
            response.send("Some id error occur");
        }
        else {
            response.send(result);
        }    
    });
});

/* 
 POST route for /user add
  with body = {
    "id":598,
    "name": "John Heng",
    "mail": "johnheng@xyz.com",
    "mobile": 91191100,
    "nric" : "S1234765F"
}
*/
app.post("/user", (request, response) => {
    console.log(request.body);
    //
    connection.query(`INSERT INTO users(user_id, name, mail, mobile, nric) 
    VALUES (${request.body.id},'${request.body.name}', '${request.body.mail}', ${request.body.mobile}, '${request.body.nric}')`, 
    (err, result) => {
        if (err) {
            response.send("Some record error occur");
        }
        else {
            response.send("Record saved successfully");
        }    
    });
});

// listen port 3000
app.listen(3000);

```

## REST and CRUD co-relation

REST | CRUD | Description
----|-----|----
GET | READ | Read record from database table
POST | CREATE | Create record into database table
PUT | UPDATE | Update record into database table
DELETE | DELETE | Delete record from database table

## Homework 2
* API express js code and validate using Postman
* API documentation

Component | Description
----|-----
API name | getUserId
Description | Get User by ID
Method | GET
URI | /user/id
Headers, Parameters, Body | body { "id" : 2 }
Response | { "user_id" : "599", "name" : "John Heng", ...}

