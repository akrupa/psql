drop table if exists tab_a;
create table tab_a(a integer ,b varchar, c date);

psql  -c "TRUNCATE TABLE tab_a"
psql -U postgres -c "COPY tab_a from '/tmp/test/t.csv' DELIMITER ',' CSV;"


-------------------------------- insert csv file
1,znaki,'2015-02-08'
2,,2015-02-08
, znaki3,
,,
5,'a',
6,"b",
~
--------------------------------


mis_db=> select * from tab_a ;
 a |    b    |     c
---+---------+------------
 1 | znaki   | 2015-02-08
 2 |         | 2015-02-08
   |  znaki3 |
   |         |
 5 | 'a'     |
 6 | b       |
(6 rows)

mis_db=>




set client_encoding to 'latin2'


