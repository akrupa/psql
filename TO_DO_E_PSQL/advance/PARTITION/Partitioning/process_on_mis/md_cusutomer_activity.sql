SET search_path TO public;

drop table if exists all_customer_activity;

create table all_customer_activity
(
  processing_date date
, msisdn_skid integer
, last_call_date date
, last_topup_date date
, churn_30_date date
, churn_90_date date
, tarrif_id            varchar(30) 
, product_skid         integer               
, pack_valid_from_date  date   
, pack_valid_to_date     date          
, data_pack_ind         varchar(1)          
, voice_pack_ind        varchar(1)          
, sms_pack_ind          varchar(1)          
, data_utilization_pct  decimal(20,4)         
, voice_utilization_pct decimal(20,4)         
, sms_utilization_pct   decimal(20,4)         
);

grant all on all_customer_activity to mis_etl;
grant select on all_customer_activity to mis;



