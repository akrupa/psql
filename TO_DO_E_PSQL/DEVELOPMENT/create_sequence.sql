drop table if exists stg_a_test_kmap;

drop sequence if exists a_test_kmap_seq;

create sequence a_test_kmap_seq
  increment by 1
  no minvalue
  no maxvalue
  start with 1
  cache 1
  cycle;

create table stg_a_test_kmap
(
  a_test_skid integer default nextval('a_test_kmap_seq')
, v  varchar (10)
);

alter sequence  a_test_kmap_seq owned by stg_a_test_kmap.a_test_skid;

insert into stg_a_test_kmap (v) values(1);
insert into stg_a_test_kmap  values(2,2);
insert into stg_a_test_kmap (v) values(3);

