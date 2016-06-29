SET search_path TO mis_intf, mis_stg, mis_prcss, public;


truncate table stg_partitioning_file_kmap;
insert into stg_partitioning_file_kmap
(
  file_skid	
, file_name
, src_id
, rec_count
, insert_time
, hash
)
select
  file_skid
, file_name
, src_id
, rec_count
, insert_time
, substr(md5(file_name), 1, 1)
from stg_file_kmap t
where not exists
( select
    1
  from
    stg_partitioning_file_kmap k 
  where
    (
      coalesce(k.file_name, '!@#$%^&*()') = coalesce(t.file_name, '!@#$%^&*()')
  and coalesce(k.src_id, '!@#$%^&*()') = coalesce(t.src_id, '!@#$%^&*()')
  and coalesce(k.rec_count, -999999) = coalesce(t.rec_count, -999999) )
)
limit 1
;

