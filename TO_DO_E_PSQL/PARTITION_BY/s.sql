-- posumowanie wartoœci w danym tygodniu

with g as
(
 SELECT
   current_date + s.a AS gen_date
 , cast( random()*100 as integer) as v
 FROM generate_series(-31,0) AS s(a)
)
,  t as
(
select
  gen_date
, v
, extract(month from gen_date) as month_of_year
, extract(week from gen_date) as week_of_year
, extract( dow from gen_date) as day_of_week
, extract(day from gen_date) as day_of_month
from g
order by 1 desc
)
select
t.*
, sum(v) over (partition by month_of_year, week_of_year)
from t

