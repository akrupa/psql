drop table if exists public.BUNDLE_SKU;
create table  public.BUNDLE_SKU
(
parent   integer,
child  integer,
QUANTITY   integer
);


insert into  public.BUNDLE_SKU values(1,2,2);
insert into  public.BUNDLE_SKU values(2,3,3);
insert into  public.BUNDLE_SKU values(3,4,4);
insert into  public.BUNDLE_SKU values(3,4,5);


with recursive hierarchy as
( select distinct child parent, child, 1 QUANTITY, 0 ld
  from public.BUNDLE_SKU 
  union all
  select next.parent, prev.child, prev.QUANTITY * next.QUANTITY, prev.ld + 1
  from hierarchy prev join  public.BUNDLE_SKU next on prev.parent = next.child
) select * from hierarchy;


-- mis_db=> with recursive hierarchy as
-- mis_db-> ( select distinct child parent, child, 1 QUANTITY, 0 ld
-- mis_db(>   from public.BUNDLE_SKU
-- mis_db(>   union all
-- mis_db(>   select next.parent, prev.child, prev.QUANTITY * next.QUANTITY, prev.ld + 1
-- mis_db(>   from hierarchy prev join  public.BUNDLE_SKU next on prev.parent = next.child
-- mis_db(> ) select * from hierarchy;
--  parent | child | quantity | ld
-- --------+-------+----------+----
--       2 |     2 |        1 |  0
--       3 |     3 |        1 |  0
--       4 |     4 |        1 |  0
--       1 |     2 |        2 |  1
--       2 |     3 |        3 |  1
--       3 |     4 |        4 |  1
--       3 |     4 |        5 |  1
--       1 |     3 |        6 |  2
--       2 |     4 |       12 |  2
--       2 |     4 |       15 |  2
--       1 |     4 |       24 |  3
--       1 |     4 |       30 |  3
-- (12 rows)
