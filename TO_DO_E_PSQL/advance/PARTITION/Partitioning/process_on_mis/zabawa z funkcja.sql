psql -U mis_data -c "DROP TRIGGER insert_trigger_customer_activity  ON customer_activity;"
psql -U mis_data -c "DROP TRIGGER insert_all_trigger_customer_activity  ON customer_activity;"

psql -U mis_data -c "DROP TRIGGER insert_trigger_all_customer_activity  ON customer_activity;"


psql -U mis_data -c "DROP FUNCTION impressions_by_all_customer_activity_insert_trigger()"

psql -U mis_data -c "DROP FUNCTION impressions_by_customer_activity_insert_trigger()"
psql -U mis_data -c "DROP FUNCTION impressions_by_customer_activity_insert_trigger()"

select count(*) from customer_activicty where processing_date='2014-11-07';
select count(*) from customer_activity  where processing_date='2014-11-07';

 insert into customer_activity (processing_date) values('2014-11-30');
delete from customer_activity where  processing_date = '2014-11-30';
