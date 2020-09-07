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
mysqlConnection.connect((error) => {
    if (error){
        console.log(error);
    } else {
        console.log("Connection was successfull");
    }
});

console.log("...connected mysql:", mysqlConnection);

console.log("...query users table");
mysqlConnection.query(`SELECT * FROM users LIMIT 5`, (err, result) => {
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

console.log("...delete a user");

let newuser = { id: 599,
        name: "Harry Lim",
    mail: "harrylim@abc.com",
    mobile: "99887788",
    nric: "S223311A"
};

mysqlConnection.query(`DELETE FROM users WHERE user_id = ${newuser.id}`, (err, result) =>{
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

console.log("...add a record");

mysqlConnection.query(
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

