SELECT * FROM generate_series('2008-03-01 00:00'::timestamp,   '2008-03-04 12:00', '10 hours');




SELECT * FROM generate_series('2008-03-01 12:00'::timestamp,   '2008-03-04 12:00', '24 hours');


SELECT * FROM generate_series('2008-03-01'::date, '2008-03-04'::date);



with w_date as (
SELECT  generate_series FROM generate_series('2015-01-01 12:00'::timestamp,   '2015-02-04 12:00', '24 hours')
)
select * from w_date
