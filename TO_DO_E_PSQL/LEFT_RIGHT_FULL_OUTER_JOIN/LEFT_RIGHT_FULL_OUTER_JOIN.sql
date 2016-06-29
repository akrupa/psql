
drop table  if exists A;
drop table  if exists B;

create table A (id integer);
create table B (id integer);

insert into A   select generate_series(1,2);
insert into B   select generate_series(2,3);

select *
from A
JOIN B on (A.id=B.id)

--  id | id
-- ----+----
--   2 |  2


------------------- wa¿na jest kolejnoœæ kolumn nie wartoœci porównania
select *
from A
LEFT JOIN B on (A.id=B.id)

select *
from B
RIGHT JOIN A on (A.id=B.id)

select *
from B
RIGHT JOIN A on (B.id=A.id)


--  id | id
-- ----+----
--   1 |
--   2 |  2

select *
from A
RIGHT JOIN B on (A.id=B.id)

select *
from B
LEFT JOIN A on (A.id=B.id)

select *
from B
LEFT JOIN A on (B.id=A.id)


--  id | id
-- ----+----
--   2 |  2
--     |  3


------------------------------------------------------------


select *
from B
full outer  JOIN A on (B.id=A.id  )

-------------------------------------

with w as
(
 select id as a, id as b from A
)
select * from w
-- or jest zabroniony dla outer 
full outer JOIN B on (w.a=B.id or w.b=b.id)
-- ERROR:  FULL JOIN is only supported with merge-joinable or hash-joinable join conditions

-- LETH AND right jest ok

--- cross table
select 
*
from A ,B;
 id | id
----+----
  1 |  2
  1 |  3
  2 |  2
  2 |  3
(4 rows)










