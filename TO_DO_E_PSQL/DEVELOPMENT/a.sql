
create table A 
( 
  nr integer 
, arithmetic integer
);

insert into A select generate_series(1,10);

drop function up_date();

CREATE OR REPLACE FUNCTION up_date (
 ) RETURNS integer AS $$
 DECLARE
 r_a RECORD;
 sum integer;
 BEGIN
     update A set arithmetic='0';
     sum:=0;
    FOR r_a IN SELECT * FROM A LOOP
    sum:= sum+r_a.nr;
    update A set arithmetic=sum  where nr=r_a.nr;
    
    END LOOP; 

  RETURN  sum;
 END;
$$ LANGUAGE plpgsql

----




insert into mis_stg.stg_msisdn_mis_kmap(msisdn_skid,msisdn)

create table a_tmp
as
select m.msisdn_skid, m.msisdn, ctid as c
from public.msisdn m
where msisdn NOT IN 

(
select msisdn from
     (select msisdn,count(msisdn_skid) as count_msisdn_skid
     from public.msisdn
     group by 1 having
     count(msisdn_skid) > 1
     ) d
)

and m.signature IS NULL --rekord dodany przez nowy process
AND initial_sales_channel_id IN ('MNP Online', 'MNP Unknown', 'MNP POS') --jw
and m.msisdn_skid not in (select msisdn_skid from mis_stg.stg_msisdn_mis_kmap);



update msisdn m
set
msisdn_skid=k.msisdn_skid
from a_tmp a 
join mis_stg.stg_msisdn_mis_kmap k on (k.msisdn=a.msisdn)
where
(a.msisdn_skid=m.msisdn_skid and a.msisdn=m.msisdn )

;

select m.msisdn_skid, m.msisdn, '-2', current_time
from msisdn m where not exists (select 1 from mis_stg.stg_msisdn_mis_kmap k where m.msisdn=k.msisdn );


 select m.msisdn_skid, m.msisdn, '-2', current_timestamp
from msisdn m  
where not exists 
(select 1 from mis_stg.stg_msisdn_mis_kmap k where coalesce(m.msisdn, '!@#$%^&*()') = coalesce( k.msisdn, '!@#$%^&*()' )) ;






