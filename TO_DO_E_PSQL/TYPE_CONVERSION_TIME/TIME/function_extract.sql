

with g as
(
 SELECT 
   current_date + s.a AS gen_date
 , cast( random()*100 as integer) as v
 FROM generate_series(-31,0) AS s(a)
)
select
  gen_date
, v
, extract(year from gen_date) as year
, extract(month from gen_date) as month_of_year
, extract(week from gen_date) as week_of_year
, extract( dow from gen_date) as day_of_week
, extract(day from gen_date) as day_of_month
, extract(doy from gen_date) as day_of_year
, extract(epoch from gen_date) as epoch
from g;



SELECT EXTRACT(MICROSECONDS FROM TIME '17:12:28.5');
SELECT EXTRACT(MILLISECONDS FROM TIME '17:12:28.5');
SELECT EXTRACT(HOUR FROM TIMESTAMP '2001-02-16 20:38:40'); -- 0-23

SELECT EXTRACT(QUARTER FROM TIMESTAMP '2001-02-16 20:38:40');


SELECT EXTRACT(MONTH FROM TIMESTAMP '2001-02-16 20:38:40');
Result: 2

SELECT EXTRACT(MONTH FROM INTERVAL '2 years 3 months');
Result: 3

SELECT EXTRACT(MONTH FROM INTERVAL '2 years 13 months');
Result: 1


