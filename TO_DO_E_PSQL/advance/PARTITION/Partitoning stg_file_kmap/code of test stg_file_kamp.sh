
SET search_path TO mis_stg;

drop table if exists stg_partitioning_file_kmap cascade ;
drop sequence partitioning_file_kmap_seq;


create sequence partitioning_file_kmap_seq
  increment by 1
  no minvalue
  no maxvalue
  start with 1000000
  cache 1
  cycle;

create table stg_partitioning_file_kmap
(
  file_skid integer   default nextval('partitioning_file_kmap_seq')
, file_name varchar(200)
, src_id varchar(2)
, rec_count bigint
, insert_time timestamp
, hash varchar(1)
);

-------------------------------------------------------------
drop table if exists stg_file_kmap_1;
drop table if exists stg_file_kmap_2;
drop table if exists stg_file_kmap_3;
drop table if exists stg_file_kmap_4;
drop table if exists stg_file_kmap_5;
drop table if exists stg_file_kmap_6;
drop table if exists stg_file_kmap_7;
drop table if exists stg_file_kmap_8;

CREATE TABLE  stg_file_kmap_1( CHECK ( hash='0' OR hash='1' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_2( CHECK ( hash='2' OR hash='3' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_3( CHECK ( hash='4' OR hash='5' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_4( CHECK ( hash='6' OR hash='7' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_5( CHECK ( hash='8' OR hash='9' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_6( CHECK ( hash='a' OR hash='b' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_7( CHECK ( hash='c' OR hash='d' ) )  INHERITS (stg_partitioning_file_kmap);
CREATE TABLE  stg_file_kmap_8( CHECK ( hash='e' OR hash='f' ) )  INHERITS (stg_partitioning_file_kmap);


-----------------------------------------------------

START=1
END=8
{ 
echo "example "
for (( c=$START; c<=$END; c++ ))
do
	
  NAME_TAB="stg_file_kmap_$((c)) "  
  echo "  CREATE TABLE  ${NAME_TAB} ( CHECK ( hash='$((c+1*2-1-1))' ) , CHECK ( hash='$((c*2-1))' )  )  INHERITS (stg_partitioning_file_kmap); "
done
}


#------------------------------------------------------------- create trigger

{
echo "CREATE OR REPLACE FUNCTION impressions_by_day_all_customer_activity_insert_trigger() "
echo "RETURNS TRIGGER AS \$\$ "
echo "BEGIN "
echo " IF ( NEW.hash = null  ) THEN  "
echo "RAISE EXCEPTION 'Date is null.  Something wrong with the impressions_by_day_insert_trigger() function'; "

##### petala
#
START=1
END=8
{ 
for (( c=$START; c<=$END; c++ ))
do
	
 NAME_TAB="stg_file_kmap_$((c)) "  
 
  echo " ELSIF ( NEW.hash =='${c}' and  NEW.hash =='${c}' ) THEN  " 
  echo "   INSERT INTO $NAME_TAB VALUES (NEW.*); "  
done
}


#####

echo " ELSE "
echo "   RAISE EXCEPTION 'hash out of range.  Something wrong with the impressions_by_hash_insert_trigger() function!'; "
echo " END IF; "
echo "   RETURN NULL; "
echo "END; "
echo "\$\$"
echo "LANGUAGE plpgsql; "
} > create_trigger.sql

#---------------------------------------------------------------------------- end create trigger


DROP FUNCTION

DROP TRIGGER insert_day_all_customer_activity ON day_all_customer_activity;
CREATE TRIGGER insert_day_all_customer_activity 
  BEFORE INSERT ON day_all_customer_activity 
  FOR EACH ROW EXECUTE PROCEDURE impressions_by_day_all_customer_activity_insert_trigger();



 insert into stg_partitioning_file_kmap values (21,'we','ww',null,null,'1');
 insert into stg_partitioning_file_kmap (hash) values ('1');
 select * from mis_stg.stg_partitioning_file_kmap;



