insert into all_customer_activity (processing_date) values('2013-03-10');
insert into all_customer_activity (processing_date) values('2013-03-11');
insert into all_customer_activity (processing_date) values('2013-03-12');

truncate table all_customer_activity;
select * from all_customer_activity;

select count(*) from mis_part.part_customer_activity_20130310;



ALTER TABLE all_customer_activity  RENAME TO new_customer_activity;

psql -U mis_data -c "ALTER TABLE all_customer_activity  RENAME TO customer_activity;"
psql -U mis_data -c "ALTER TABLE customer_activity  RENAME TO new_customer_activity;"


psql -U mis_data -c "ALTER TABLE customer_activity  RENAME TO old_customer_activity;"
psql -U mis_data -c "ALTER TABLE old_customer_activity  RENAME TO old_customer_activity;"
