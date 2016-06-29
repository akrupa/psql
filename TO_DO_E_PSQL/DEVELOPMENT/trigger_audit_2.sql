
drop table if exists name_tab;
create table  name_tab
(
  key integer
, v   varchar
, created_by  varchar(20)
, create_ts   timestamp
, updated_by  varchar(20)
, update_ts   timestamp
);

grant all on name_tab to mis_data;

-------------------------------------------- insert
drop function if exists  name_tab_insert_func();
CREATE OR REPLACE FUNCTION name_tab_insert_func() RETURNS TRIGGER AS $$
    BEGIN
        NEW.created_by := current_user;
        NEW.create_ts := now();
      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER  name_tab_insert_trig
BEFORE  INSERT
    ON  name_tab
   FOR EACH ROW
EXECUTE PROCEDURE name_tab_insert_func();

--------------------------------------------- update
drop function if exists name_tab_update_func();
CREATE OR REPLACE FUNCTION name_tab_update_func() RETURNS TRIGGER AS $$
    BEGIN
        NEW.updated_by := current_user;
        NEW.update_ts := now();
      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER  name_tab_update_trig
BEFORE UPDATE
    ON  name_tab
   FOR EACH ROW
EXECUTE PROCEDURE name_tab_update_func();


--------------------------------------------- insert
insert into name_tab( key,v) values(1,'a');
select * from name_tab;


insert into name_tab( key,v) values(2,'b');
select * from name_tab;

-------------- nastapi zmiana w kolumnie, bêdzie lepiej widoczne , je¿eli do update bêdzie u¿yty inny  u¿ytkownik
update name_tab
set
v='c'
;

select * from name_tab;
----------  to rm

--select 'uninstall' as uninstall ;
drop TRIGGER  if exists  name_tab_update_trig  on name_tab;
drop TRIGGER  if exists  name_tab_insert_trig  on name_tab;
drop table if exists name_tab;

drop function name_tab_insert_func();
drop function name_tab_update_func();


