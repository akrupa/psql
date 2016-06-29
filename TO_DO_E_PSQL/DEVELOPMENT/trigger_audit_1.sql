/*
   Podczas dodawania rekordu uzupe³niane s¹ kolumny
, created_by  varchar(20)
, create_ts   timestamp
*/

drop table if exists name_tab;
create table  name_tab
(
  key integer
, v   varchar
, created_by  varchar(20)
, create_ts   timestamp
);



drop function name_tab_func();
CREATE OR REPLACE FUNCTION name_tab_func() RETURNS TRIGGER AS $$
    BEGIN
        NEW.created_by := current_user;
        NEW.create_ts := now();
      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';




CREATE TRIGGER  name_tab_trig
BEFORE UPDATE OR INSERT
    ON  name_tab
   FOR EACH ROW
EXECUTE PROCEDURE name_tab_func();


insert into name_tab( key,v) values(1,'a');
select * from name_tab;


insert into name_tab( key,v) values(2,'b');
select * from name_tab;

-------------- nastapi zmiana w kolumnie
update name_tab
set
v='c'
;

select * from name_tab;
----------  to rm
select 'uninstall' as uninstall ;
drop TRIGGER  if exists  name_tab_trig  on name_tab;
drop function name_tab_func();
drop table if exists name_tab;


