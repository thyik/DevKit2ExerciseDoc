# Homework 1 

## Create database & table

```sql

// users table
CREATE TABLE users (
  user_id int  ,
  name varchar(50)  ,
  mail varchar(50)  ,
  mobile varchar(50)  ,
  nric varchar(50)  
)

// accounts table
CREATE TABLE accounts (
  user_id int,
  acct_type varchar(50),
  acct_number bigint,
  balance decimal(10,2),
  date_created date,
  max_limit decimal(10,2)
)

// transactions table
CREATE TABLE transactions (
  acct_number bigint,
  id bigint,
  date datetime,
  type varchar(50),
  amount decimal(10,2)
)

// messages table
CREATE TABLE messages (
  user_id int,
  id int,
  date datetime,
  remark text

```

## Generate Random data

* [mockaroo](https://www.mockaroo.com)
  + [users csv](./mock_data/users.csv)
  + [accounts csv](./mock_data/accounts.csv)
  + [transactions sql](./mock_data/transactions.sql)
  + [messages sql](./mock_data/mesages.sql)

## Import data to table

### import sql format data

```sql
mysql> source E:/downloads/users.sql;

```

### import csv format data (This is a bit more tricky)
* for windows, need to put the csv file to the upload folder. Else the command will not have privilege to execute
* [reference](https://riptutorial.com/mysql/example/10715/import-a-csv-file-into-a-mysql-table)

```sql

// query for folder location to upload .csv file 
mysql> SHOW VARIABLES LIKE "secure_file_priv";

// users
mysql> LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv"
INTO TABLE nusbank.users
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

// accounts
mysql> LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/accounts.csv"
INTO TABLE nusbank.accounts
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

// transactions
mysql> source E:/downloads/transactions.sql;

// messages
mysql> source E:/downloads/messages.sql;

```

## Dump the database

* Goto Command Prompt. Type this command to dump to file (d:/nusbank.sql)
```sh
C:> "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u root -p nusbank > d:/nusbank.sql
```

## Data Queries

* show average transaction of an account
```sql

// show transactions with match to the account users id
// table1 = transactions
// table2 = accounts
SELECT a.user_id, a.acct_number, t.amount
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
ORDER BY a.user_id

// show all users acct with and without transaction
SELECT a.user_id, a.acct_number, t.amount
FROM transactions AS t
RIGHT JOIN accounts AS a
ON a.acct_number = t.acct_number
ORDER BY a.user_id

// show transactions without matching user account (phantom transaction)
// ?? something wrong with transactions dataset....
SELECT a.user_id, a.acct_number, t.amount
FROM transactions AS t
LEFT JOIN accounts AS a
ON a.acct_number = t.acct_number
ORDER BY a.user_id


/// average transactions for each user
SELECT a.user_id, a.acct_number, AVG(t.amount)
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY a.user_id
ORDER BY a.user_id

/// average transactions for each user
SELECT a.user_id, a.acct_number, AVG(t.amount)
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY a.user_id
ORDER BY a.user_id

// average maonthly transactions for each user
// ? mix of multiple year?
SELECT a.user_id, a.acct_number, t.date, AVG(t.amount)
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY a.user_id, MONTH(t.date)
ORDER BY a.user_id

//
INSERT INTO transactions (acct_number, id, date, type, amount)
VALUES (337941218931961, 99999999, '2020-09-29 16:00:09', 'grocery', 99.00);


// Ans : average monthly transactions for each users 
SELECT a.user_id, a.acct_number, t.date, AVG(t.amount)
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY a.user_id, MONTH(t.date), YEAR(date)
ORDER BY a.user_id

// show count of each type of transaction for each user
SELECT a.user_id, a.acct_number, t.date, COUNT(t.type)
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY a.user_id, t.type
ORDER BY a.user_id

// Ans : show most frequent transaction type
/// ?? count correct BUT display match to wrong type
// nested query
SELECT t1.user_id, t1.ttype, MAX(t1.ctype)
FROM (SELECT a.user_id, a.acct_number, t.date, t.type as ttype, COUNT(t.type) as ctype
      FROM transactions AS t
      INNER JOIN accounts AS a
      ON a.acct_number = t.acct_number
      GROUP BY a.user_id, t.type
      ORDER BY a.user_id) as t1
GROUP BY t1.user_id;

// show sum of all users
SELECT u.user_id, u.name, SUM(a.balance) FROM accounts AS a
INNER JOIN users AS u
ON a.user_id = u.user_id
GROUP BY a.user_id
ORDER BY u.user_id;

// show highest balance
SELECT u.user_id, u.name, SUM(a.balance) AS total FROM accounts AS a
INNER JOIN users AS u
ON a.user_id = u.user_id
GROUP BY a.user_id
ORDER BY total DESC
LIMIT 1

// show lowest balance
SELECT u.user_id, u.name, SUM(a.balance) AS total FROM accounts AS a
INNER JOIN users AS u
ON a.user_id = u.user_id
GROUP BY a.user_id
ORDER BY total ASC
LIMIT 1


///Ans: find highest monthly transaction
SELECT a.user_id, u.name, a.acct_number, t.date, COUNT(a.user_id) as cmonth
FROM transactions AS t
INNER JOIN accounts AS a
ON a.acct_number = t.acct_number
INNER JOIN users AS u
ON u.user_id = a.user_id
GROUP BY a.user_id, MONTH(t.date), YEAR(t.date)
ORDER BY cmonth DESC
LIMIT 1


//// Misc
// show each user account number
mysql> SELECT a.user_id, u.name, a.acct_number, a.acct_type from accounts AS a 
INNER JOIN users AS u 
ON a.user_id = u.user_id
GROUP BY a.acct_number
ORDER BY a.user_id;

// show each user average monthly spending
mysql> SELECT t.date, a.user_id, t.acct_number, AVG(t.amount) from transactions AS t
JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY YEAR(t.date), MONTH(t.date)
ORDER BY t.date;

// show each account average spending
mysql> SELECT a.user_id, t.acct_number, AVG(t.amount) from transactions AS t
JOIN accounts AS a
ON a.acct_number = t.acct_number
GROUP BY t.acct_number
ORDER BY a.user_id;

// show most frequent transaction type
mysql> SELECT MAX(t.type) FROM transactions AS t;
mysql> SELECT t.type, COUNT(t.type) FROM transactions AS t;

// show customer who have lowest and highest balance

// show total balance of each user accounts
mysql> SELECT a.user_id, SUM(a.balance) FROM accounts AS a
GROUP BY a.user_id;
```