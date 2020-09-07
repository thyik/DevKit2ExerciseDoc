const mysql = require("mysql");

parameters = {
    host: "localhost",
    user: "root",
    password: "7572137",
    database: "nusbank",
    multipleStatements: true,
};

console.log("...connecting mysql:", parameters);
mysqlConnection = mysql.createConnection(parameters);
mysqlConnection.connect();

console.log("...connected mysql:", mysqlConnection);

console.log("...query users table");
mysqlConnection.query(`SELECT * FROM users`, (err, result) => {
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

console.log("...delete a user");
let id = 599;
mysqlConnection.query(`DELETE FROM users WHERE user_id = ${id}`, (err, result) =>{
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

console.log("...add a record");
let name = "Harry Lim";
let mail = "harrylim@abc.com";
let mobile = 99999;
let nric = "S1234532A";

mysqlConnection.query(
    `INSERT INTO users(user_id, name, mail, mobile, nric) 
    VALUES (${id},'${name}', '${mail}', ${mobile}, '${nric}')`,
    (err, results) => {
        if (err){
            console.log(err);
        } else {
            if (results["affectedRows"] != 0) {
                console.log("Added", results);
            }
        }        
    });

