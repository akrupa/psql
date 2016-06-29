
drop table if exists tab_a;
create table tab_a
(
  a varchar(40)
, b timestamp
, c integer 
);

insert into tab_a values('a', current_timestamp,0);
insert into tab_a values('b', current_timestamp,0);
insert into tab_a values('c', current_timestamp,0);


select '-------------------- update --------------';



drop function if exists  f_tab_a_update();
CREATE OR REPLACE FUNCTION  f_tab_a_update() RETURNS TRIGGER AS $$
    BEGIN

      IF OLD.a is  null and NEW.a is not null and NEW.b is null then
        NEW.b := now();
      else
      end if;
      NEW.c := 1;    
      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER  trig_tab_a_update
BEFORE  UPDATE
    ON  tab_a
   FOR EACH ROW
EXECUTE PROCEDURE  f_tab_a_update();

start transaction isolation level repeatable read;
update tab_a
set
  a='u'
, b='2000-01-01'
where a='a';
commit;
select * from tab_a;


