cat  l.sql  | awk  -F , '{print "insert into tmp_calendar values( \047" $1 "\047 ," $2 "," $3 "," $4 ",\047" $5 "\047, \047 " $6 "\047 , \047"  $7 "\047 ,\047" $8 "\047,\047" $9 "\047," $10 "," $11 ", \047" $12 "\047 , \047 " $13 "\047 ," $14 "," $15 ",\047" $16  "\047,\047" $17 "\047,\047" $18 "\047,\047" $19 "\047," $20 ",\047" $21 " \047," $22 "," $23 "," $24 "," $25 "," $26 ",\047" $27 "\047, \047" $28 "\047);" }'


# dane wygenerowane wrzucamy metod¹ kopjuj wklej 

# dodajemy columne calendar_id
cat  Calendar2017v2.csv   | while read line;
do
    p=$(echo "$line" | awk -F ';' '{print $1}' | sed 's/-//g' )
echo "${line} ${p};;; "
done

#############################################  ladujemy dane
# psql -U mis_etl -c "COPY tmp_calender from '/home/mis/akrupa/Calendar2017v3.csv' DELIMITER ';' CSV;"


########################## uzupelniamy danymi kolumne 
# first_day_of_month | last_day_of_month | holiday_flag

update public.calendar
set
  holiday_flag='n'
where year > 2016
;


update public.calendar c
set
  holiday_flag='y'
where exists
(
  select 1
  from holiday h
  where (h.year = 0 or  h.year = c.year )  and h.month = c.month and h.day = c.day_num_in_month
)
and year >2015
;

update public.calendar c
set
   first_day_of_month=date_trunc('month', full_date)::date
,  last_day_of_month=(date_trunc('month', full_date+ interval '1 month'  )::date  - interval '1 day')::date
where
 year > 2016
;


######################################################## tab holiday

drop table if exists public.holiday;
create table public.holiday
(
  year  smallint
, month smallint
, day   smallint
, description varchar(200)
);

grant all on public.holiday to mis_etl;
grant select on public.holiday to mis;



insert into public.holiday values(0,  1, 1, NULL);
insert into public.holiday values(0,  1, 6, NULL);
insert into public.holiday values(0,  5,  1, NULL);
insert into public.holiday values(0,  5,  3, NULL);
insert into public.holiday values(0,  8, 15, NULL);
insert into public.holiday values(0, 11,  1, NULL);
insert into public.holiday values(0, 11, 11, NULL);
insert into public.holiday values(0, 12, 25, NULL);
insert into public.holiday values(0, 12, 26, NULL);

------------------------------------------------------- 2016
insert into public.holiday values(2016,  3, 27, NULL);
insert into public.holiday values(2016,  3, 28, NULL);
insert into public.holiday values(2016,  5, 15, NULL);
insert into public.holiday values(2016,  5, 26, NULL);


------------------------------------------------------- 2017
insert into public.holiday values(2017,  4, 16, NULL);
insert into public.holiday values(2017,  4, 17, NULL);
insert into public.holiday values(2017,  6,  4, NULL);
insert into public.holiday values(2017,  6, 15, NULL);


------------------------------------------------------- 2018
insert into public.holiday values(2018,  4,  1, NULL);
insert into public.holiday values(2018,  4,  2, NULL);
insert into public.holiday values(2018,  5, 20, NULL);
insert into public.holiday values(2018,  5, 31, NULL);



------------------------------------------------------- 2019
insert into public.holiday values(2019,  4, 21, NULL);
insert into public.holiday values(2019,  4, 22, NULL);
insert into public.holiday values(2019,  6,  9, NULL);
insert into public.holiday values(2019,  6, 20, NULL);


------------------------------------------------------- 2020
insert into public.holiday values(2020,  4, 12, NULL);
insert into public.holiday values(2020,  4, 13, NULL);
insert into public.holiday values(2020,  5, 31, NULL);
insert into public.holiday values(2020,  6, 11, NULL);

############################################################# end Holiday





