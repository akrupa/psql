
drop table if exists tab_a;
create table tab_a
(
  a varchar(40)
, b timestamp
);

insert into tab_a values('a', current_timestamp);

select * from tab_a;


drop function if exists  f_tab_a();
CREATE OR REPLACE FUNCTION  f_tab_a() RETURNS TRIGGER AS $$
    BEGIN

      IF NEW.a is not null and NEW.b is null  then
        NEW.b := now();
      else
      end if;

      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER  trig_tab_a
BEFORE  INSERT
    ON  tab_a
   FOR EACH ROW
EXECUTE PROCEDURE  f_tab_a();

insert into tab_a values('b', current_date);
insert into tab_a values(null, null);


select * from tab_a;

select '-------------------- update --------------';



drop function if exists  f_tab_a_update();
CREATE OR REPLACE FUNCTION  f_tab_a_update() RETURNS TRIGGER AS $$
    BEGIN

      IF OLD.a is  null and NEW.a is not null and NEW.b is null then
        NEW.b := now();
      else
      end if;

      RETURN NEW;
    END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER  trig_tab_a_update
BEFORE  UPDATE
    ON  tab_a
   FOR EACH ROW
EXECUTE PROCEDURE  f_tab_a_update();

update tab_a
set
a='u'
b='2000-01-01'
where a is null;

select * from tab_a;


