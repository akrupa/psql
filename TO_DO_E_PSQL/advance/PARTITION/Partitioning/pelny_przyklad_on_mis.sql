
drop table if exists day_all_customer_activity;

create table public.day_all_customer_activity
(
  processing_date date
, msisdn_skid integer
, last_call_date date
, last_topup_date date
, churn_30_date date
, churn_90_date date
);

DROP TABLE day_customer_activity_20140915;
CREATE TABLE day_customer_activity_20140915 (
	CHECK ( processing_date= date('2014-09-15') )
) INHERITS (day_all_customer_activity);


DROP TABLE day_customer_activity_20140916;
CREATE TABLE day_customer_activity_20140916 (
	CHECK ( processing_date= date('2014-09-16') )
) INHERITS (day_all_customer_activity);



CREATE OR REPLACE FUNCTION impressions_by_day_all_customer_activity_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
 IF ( NEW.processing_date = date('2014-09-15')  ) THEN 
   INSERT INTO day_customer_activity_20140915 VALUES (NEW.*); 
 ELSIF ( NEW.processing_date = date('2014-09-16') ) THEN 
   INSERT INTO day_customer_activity_20140916 VALUES (NEW.*);
 ELSE
   RAISE EXCEPTION 'Date out of range.  Something wrong with the impressions_by_day_insert_trigger() function!';
 END IF;
   RETURN NULL;
END;
$$
LANGUAGE plpgsql;


-----------------------
DROP TRIGGER insert_day_all_customer_activity ON day_all_customer_activity;
CREATE TRIGGER insert_day_all_customer_activity 
	BEFORE INSERT ON day_all_customer_activity 
	FOR EACH ROW EXECUTE PROCEDURE impressions_by_day_all_customer_activity_insert_trigger();


select * from day_customer_activity_20140915;
select * from day_all_customer_activity;

INSERT INTO day_all_customer_activity 
select * from customer_activity where 
processing_date='2014-09-15' limit 10;

select processing_date ,count(*) from day_all_customer_activity group by 1 order by 1;


-------
 CREATE TABLE  mis_part.part_customer_activity_20140928  ( CHECK ( processing_date= date('2014-09-28') )  )  INHERITS (day_all_customer_activity);
 CREATE TABLE  mis_part.part_customer_activity_20140929  ( CHECK ( processing_date= date('2014-09-29') )  )  INHERITS (day_all_customer_activity);
 CREATE TABLE  mis_part.part_customer_activity_20140930  ( CHECK ( processing_date= date('2014-09-30') )  )  INHERITS (day_all_customer_activity);

insert into part_customer_activity_20140929 (processing_date) values('2014-09-29');


insert into customer_activity (processing_date) values('2014-09-29');
insert into customer_activity (processing_date) values('2014-10-07');

insert into customer_activity (processing_date) values('2013-03-10');


insert into customer_activity (processing_date) values('2014-11-30');





