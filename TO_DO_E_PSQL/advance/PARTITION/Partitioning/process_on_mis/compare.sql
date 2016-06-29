select * from all_customer_activity;

select  count(*) from all_customer_activity;
select count(*) from mis_part.part_customer_activity_20130310

select count(*) from all_customer_activity;

select count(*) from mis_part.part_customer_activity_20141103;
select count(*) from mis_part.part_customer_activity_20141102;
select count(*) from mis_part.part_customer_activity_20141101;

select count(*) from customer_activity where processing_date between '2014-11-01' and '2014-11-03';

select count(*) from all_customer_activity where processing_date between '2014-11-01' and '2014-11-01';


select sum(cast(tab_size as bigint  )), count(*), current_time
from 
(

    SELECT
    table_schema || '.' || table_name AS table_full_name,
    pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') AS tab_size
FROM information_schema.tables
where table_name like '%part_customer%'
ORDER BY
    pg_total_relation_size('"' || table_schema || '"."' || table_name || '"') DESC
) p
where p.tab_size<>0

