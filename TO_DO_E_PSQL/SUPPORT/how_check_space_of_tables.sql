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
where p.tab_size > 1000000

