const mysql = require("mysql");

parameters = {
    host: "localhost",
    user: "root",
    password: "7572137",
    database: "nusbank",
    multipleStatements: true,
};

console.log("...connecting mysql:", parameters);
let connection = mysql.createConnection(parameters);
connection.connect((error) => {
    if (error){
        console.log(error);
    } else {
        console.log("Connection was successfull");
    }
});

console.log("...connected mysql:", connection);

console.log("...query users table");
connection.query(`SELECT * FROM users LIMIT 5`, (err, result) => {
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

connection.query(`DELETE FROM users WHERE user_id = ${newuser.id}`, (err, result) =>{
    if (err){
        console.log(err);
    }else{
        console.log(result);
    }
});

console.log("...add a record");

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
                console.log("Highest Monthly", results);
            }
        }        
    });