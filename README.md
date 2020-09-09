# Database

## Tools

* mySQL

## MySQL Datatypes

Ty p e | S i z e | D e s c r i p t i o n
-----|-----|---
CHAR[Length] | Length bytes | A fixed-length field from 0 to 255 characters long.
VARCHAR(Length) | String length + 1 bytes | A fixed-length field from 0 to 255 characters long.
TINYTEXT | String length + 1 bytes | A string with a maximum length of 255 characters.
TEXT | String length + 2 bytes | A string with a maximum length of 65,535 characters.
MEDIUMTEXT | String length + 3 bytes | A string with a maximum length of 16,777,215 characters.
LONGTEXT | String length + 4 bytes | A string with a maximum length of 4,294,967,295 characters.
TINYINT[Length] | 1 byte | Range of -128 to 127 or 0 to 255 unsigned.
SMALLINT[Length] | 2 bytes | Range of -32,768 to 32,767 or 0 to 65535 unsigned.
MEDIUMINT[Length] | 3 bytes | Range of -8,388,608 to 8,388,607 or 0 to 16,777,215 unsigned.
INT[Length] | 4 bytes | Range of -2,147,483,648 to 2,147,483,647 or 0 to 4,294,967,295 unsigned.
BIGINT[Length] | 8 bytes | Range of -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 or 0 to 18,446,744,073,709,551,615 unsigned.
FLOAT | 4 bytes | A small number with a floating decimal point.
DOUBLE[Length, Decimals] | 8 bytes | A large number with a floating decimal point.
DECIMAL[Length, Decimals] | Length + 1 or Length + 2 bytes | A DOUBLE stored as a string, allowing for a fixed decimal point.
DATE | 3 bytes | In the format of YYYY-MM-DD.
DATETIME | 8 bytes | In the format of YYYY-MM-DD HH:MM:SS.
TIMESTAMP | 4 bytes | In the format of YYYYMMDDHHMMSS; acceptable range ends inthe year 2037.
TIME | 3 bytes | In the format of HH:MM:SS
ENUM | 1 or 2 bytes | Short for enumeration, which means that each column can haveone of several possible values.
SET | 1, 2, 3, 4, or 8 bytes | Like ENUM except that each column can have more than one ofseveral possible values.


## SQL Client

* Part 1

```sql
mysql> show databases;

mysql> create database test_db;

mysql> show databases;

mysql> use test_db;

mysql> show tables;

mysql> create table users (
       user_id INT,
       name VARCHAR(50),
       dob DATE,
       mobile_number INT,
       ic_number INT
);

// show table fields design
mysql> describe users;

// add new column
mysql> alter table users add verify INT;

// delete column
mysql> alter table users drop column verify;

// modify field type
mysql> alter table users modify column verify varchar(100);

// insert record into table
mysql> insert into users (user_id, name, mobile_number)
       values (123, 'dixant', 9988222);

// dob in yyyy-mm-dd
mysql> insert into users (user_id, name, mobile_number, dob)
       values (123, 'dixant', 9988222, '1975-12-01');

// add multiple records
mysql> insert into users (user_id, name, mobile_number)
       values (125, 'john', 99882221), (126, 'harry', 99882223);

// view table records
mysql> select * FROM users

//update a record
mysql> update users set dob = '1976-01-01' where user_id = 123;

// delete record
mysql> delete from users where dob > '1976-01-01';

// create new database
mysql> create database ntuc;

mysql> use ntuc;

// create grocery table
mysql> create table grocery (
         tag INT,
         name VARCHAR(100),
         brand VARCHAR(100),
         price DECIMAL(10,2),
         quantity INT
);

// rename table
mysql> alter table grocery rename to store;

```

* Part 2

```sql
// open database
mysql> use ntuc;

// import script from .sql file
mysql> source C:\...\data.sql

mysql> show tables;

// queries filter order by ascending order
mysql> select * from customer where customer_wallet > 5000 order by customer_wallet order by asc;

// order by wallet then tolerance
mysql> select * from customer where customer_wallet > 5000 order by customer_wallet desc, customer_tolerance order by asc;

// only display name& email order by wallet then tolerance
mysql> select customer_name, customer_email from customer where customer_wallet > 5000 order by customer_wallet desc, customer_tolerance order by asc;


/// nested queries select within select
mysql> select customer_name from 
        (select * from customer where customer_wallet > 3000) as temp
        where customer_tolerance > 0.5;

// filter using IN clause
mysql> select * from customer where customer_tolerance IN (0.5, 0.6, 0.7);

mysql> select * from customer where custome tolerance 
        IN (select customer_tolerance where customer_tolerance < 0.8);

// ans for exercise
mysql> select * from transaction where customer_id
       in (select customer_id from customer where customer_tolerance < 0.7);        
///

```

* common functions
  * COUNT
  * SUM
  * AVG
  * MAX
  * MIN

```sql
// sum
mysql> select SUM(customer_wallet) from customer;

// average
mysql> select AVG(customer_wallet) from customer;

/// number of records
mysql> select COUNT(customer_wallet) from customer;


```  

* Others functions
  * CURRENT_DATE
  * [Complete List](https://www.w3schools.com/sql/sql_ref_mysql.asp)

* `Group By` Clause

```sql
// group and sum by type..
mysql> select customer_type, sum(customer_wallet) from customer group by customer_type;

// exclude type 2
mysql> select customer_type, sum(customer_wallet) from customer 
    where customer_type <> 2
    group by customer_type;

```

* `LIMIT` Clause
  * limit the number of record to return

```sql
// show onlt first 5 records
mysql> select * from customer limit 5;

```

* `LIKE` Clause
  * pattern match
  * wildcard
    + `%` : substitute any number of character
    + `_` : substitute only one character

```sql
// show name start with Z
mysql> select * from customer where customer_name LIKE 'Z%';

```

* `UNION` Clause
  * combine data from different table
  * performance optimisation

```sql
mysql> select customer_id from customer
        UNION
        select transaction_id from transaction;

mysql> select seller_name as name from seller 
    UNION select product_name from product;

// in comparison with OR, UNION is better performance
mysql> select customer_name from customer where customer_wallet = 6000 UNION
      select customer_name from customer where customer_wallet = 8000;
```

* `INNER JOIN` clause
  * aggregates data from different tables

```sql
// join [transaction] and [customer] table
mysql> SELECT transaction.transaction_id, transaction.transaction_datetime, customer.customer_name 
       FROM transaction
       INNER JOIN customer 
       ON customer.customer_id = transaction.customer_id;

// alias AS to simplify
mysql> SELECT t.transaction_id, t.transaction_datetime, c.customer_name 
       FROM transaction AS t 
       INNER JOIN customer AS c 
       ON c.customer_id = t.customer_id;
``` 
* `LEFT JOIN` clause
  * return data from first table

```sql
// alias AS to simplify
mysql> SELECT t.transaction_id, t.transaction_datetime, c.customer_name 
       FROM transaction AS t 
       LEFT JOIN customer AS c 
       ON c.customer_id = t.customer_id
       GROUP BY c.customer_id;

mysql> SELECT c.customer_name, t.transaction_id, t.transaction_datetime
       FROM customer AS c 
       LEFT JOIN transaction AS t 
       ON c.customer_id = t.customer_id
       GROUP BY c.customer_id;
``` 

* `RIGHT JOIN` clause
  * return data from first table
```sql
mysql> SELECT t.transaction_id, t.transaction_datetime, c.customer_name 
       FROM transaction AS t 
       RIGHT JOIN customer AS c 
       ON c.customer_id = t.customer_id;

``` 

* `OUTER JOIN` clause
  * 3 types
    + LEFT OUTER JOIN
    + RIGHT OUTER JOIN
    + FULL OUTER JOIN

* INDEX clause
  * speed up search queries
```sql
mysql> CREATE INDEX 
       ON ;

```

* `PRIMARY KEY` clause
  * constraint to force unique values

```sql
mysql> CREATE TABLE table1( 
       COL1 INT
       COL2 INT)
       PRIMARY KEY (COL1);

//
mysql> ALTER TABLE Persons
ADD PRIMARY KEY (ID);      

// change to auto increment
ALTER TABLE users CHANGE user_id user_id INT(1) UNSIGNED NOT NULL AUTO_INCREMENT;

// change date to auto generate current datetime timestamp
ALTER TABLE transactions MODIFY date DATETIME NOT NULL DEFAULT NOW();
```  

* `FOREIGN KEY` clause
  * 

```sql
mysql> ALTER TABLE table2
       ADD FOREIGN KEY (COL2) REFERENCES table1(COL2);
```

## Practical Exercise #4 

### Trial Result

```sql
// Q1
mysql> SELECT t.transaction_id, t.transaction_datetime, c.customer_name 
       FROM transaction AS t 
       INNER JOIN customer AS c 
       ON c.customer_id = t.customer_id;

// Q2
mysql> select customer_id, max(transaction_datetime) from transaction group by customer_id;

// Q3
mysql> select seller_id, avg(transaction_amount) from transaction group by seller_id;

mysql> select s.seller_id, s.seller_name, avg(t.transaction_amount) FROM seller AS s
        RIGHT JOIN transaction AS t
        ON s.seller_id = t.seller_id
        GROUP BY s.seller_id;

```

### Model Answers

```sql
// Q1
mysql> select c.customer_name, t.transaction_datetime from customer as c left join transaction as t on c.customer_id = t.customer_id;


// Q2
mysql> select c.customer_name, max(t.transaction_datetime) from customer as c left join transaction as t on c.customer_id = t.customer_id group by c.customer_id;


// Q3
mysql> select s.seller_name, avg(t.transaction_amount) from seller as s left join transaction as t on s.seller_id = t.seller_id group by s.seller_id;
```

## Data mock tools
* [mockaroo](https://www.mockaroo.com/)
* [generatedata](https://www.generatedata.com/)

## Using MySQL Shell
1. Switch to SQL mode
```sql
MySQL JS> \sql

// connect data
MySQL JS> \connect root@localhost:3306

// proceed with normal sql command
MySQL localhost:3306 ssl SQL> show databases;

// open ntuc db
MySQL localhost:3306 ssl SQL> use ntuc;

// show tables in ntuc
MySQL localhost:3306 ssl SQL> show tables;

// show store_test table description
MySQL localhost:3306 ssl SQL> describe store_test;

// display table records
MySQL localhost:3306 ssl SQL> select * from store_test;



```

## Generate sql Dump data

1. Windows command prompt. Execute below command

```shell
// change to MySQL binary folder
C:\> "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u root -p nusbank > d:/nusbank.sql

```

[Next](./server-side.md)