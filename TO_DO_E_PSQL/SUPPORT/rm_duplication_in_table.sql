------- to rm
drop table if exists T;

-------
create table T (
  ak  varchar(30) -- klucz
, bk  varchar(30) -- klucz
, nr  integer
);

---decyzja o tym jak rozumiemy klucz jest wy��cznie nasza

insert into T values( 'A', 'B',5);
insert into T values( 'A', 'B',5);
insert into T values( 'A', 'B',5);
insert into T values( 'A', 'B',5);
insert into T values( 'A', 'C',5);


-------------
start transaction isolation level repeatable read;
delete from T
where (ak,bk,ctid)  -- mo�na powiedzie�, �e wystarcza samo ctid
in (
   -- zwracamy rekody do usuni�cia , pole CTID zapewni na unikalno�� 	
   select ak,bk,ctid from 
   (
    ----------- select nr rekordy po kluczu    	
   select 
     *
   , ctid
   , row_number() over(partition by ak, bk) as rn
   from T
   ) d  where rn > 1
)


