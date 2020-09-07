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

// route for user query
app.get("/user", (request, response) => {
    connection.query("SELECT * FROM users LIMIT 5", (err, result) => {
        if (err) {
            response.send("Some error occur");
        }
        else {
            response.send(result);
        }    
    });
});

// listen port 3000
app.listen(3000);