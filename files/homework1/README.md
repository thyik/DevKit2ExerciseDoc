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

// show each user account number
mysql> SELECT a.user_id, u.name, a.acct_number, a.acct_type from accounts AS a 
INNER JOIN users AS u 
ON a.user_id = u.user_id
GROUP BY a.acct_number
ORDER BY a.user_id;

// show each user average monthly spending

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