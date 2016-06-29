drop table if exists p;
create table p
( 
   row_id integer
,  key  varchar(1)
,  value integer
);


-- 0001
insert into p values(1, 'D',1);
-- 0010
insert into p values(2, 'C',1);
-- 0011
insert into p values(3, 'C',1);
insert into p values(3, 'D',1);
-- 0100
insert into p values(4, 'B',1);
-- 0101
insert into p values(5, 'D',1);
insert into p values(5, 'B',1);
-- 0110
insert into p values(6, 'B',1);
insert into p values(6, 'C',1);
-- 0111
insert into p values(7, 'B',1);
insert into p values(7, 'C',1);
insert into p values(7, 'D',1);
-- 1000
insert into p values(8, 'A',1);
-- 1001
insert into p values(9, 'A',1);
insert into p values(9, 'D',1);
-- 1010
insert into p values(10, 'A',1);
insert into p values(10, 'C',1);
-- 1011
insert into p values(11, 'A',1);
insert into p values(11, 'C',1);
insert into p values(11, 'D',1);
-- 1100
insert into p values(12, 'A',1);
insert into p values(12, 'B',1);
-- 1101
insert into p values(13, 'A',1);
insert into p values(13, 'D',1);
insert into p values(13, 'B',1);
-- 1110
insert into p values(14, 'A',1);
insert into p values(14, 'B',1);
insert into p values(14, 'C',1);
-- 1111
insert into p values(15, 'A',1);
insert into p values(15, 'B',1);
insert into p values(15, 'C',1);
insert into p values(15, 'D',1);




select 
  r.row_id
, case when a.key is null then 0 else a.value end as  A
, case when b.key is null then 0 else b.value end as  B
, case when c.key is null then 0 else c.value end as  C
, case when d.key is null then 0 else d.value end as  D
from (select distinct row_id from p order by row_id) r
left join P d on (d.row_id=r.row_id and d.key='D')
left join P c on (c.row_id=r.row_id and c.key='C')
left join p b on (b.row_id=r.row_id and b.key='B')
left join p a on (a.row_id=r.row_id and a.key='A')
order by r.row_id asc 
;


select
a ||''||c ||''|| b ||''|| d, a*2^3+b*2^2+c*2+d as binar
from 
(
  select 
    r.row_id
  , case when a.key is null then 0 else a.value end as  A
  , case when b.key is null then 0 else b.value end as  B
  , case when c.key is null then 0 else c.value end as  C
  , case when d.key is null then 0 else d.value end as  D
  from (select distinct row_id from p order by row_id) r
  left join P d on (d.row_id=r.row_id and d.key='D')
left join P c on (c.row_id=r.row_id and c.key='C')
  left join p b on (b.row_id=r.row_id and b.key='B')
  left join p a on (a.row_id=r.row_id and a.key='A')
  order by r.row_id asc 
) e
;

