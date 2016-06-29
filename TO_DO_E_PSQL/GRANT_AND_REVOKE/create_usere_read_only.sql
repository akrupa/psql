 Postgres grant select access on all tables in a database
It is not possible to create a user with read only access on a particular database. Instead we can do it at schema level in this way.

1) Grant connect to database
GRANT CONNECT ON DATABASE <db name> to <user name>;

2) Grant usage on schema
GRANT USAGE ON SCHEMA <schema name> TO <user name>;

3) Grant select on all tables in a schema using
GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <user name>;

4) Also make this privilege available for new tables added in future using
ALTER DEFAULT PRIVILEGES IN SCHEMA <schema name> GRANT SELECT ON TABLES TO <user name>;

So if we have many schemas we can simply do this way

1) SELECT 'GRANT USAGE ON SCHEMA ' || nspname || ' TO <user name>;' FROM pg_namespace WHERE nspname not like 'pg%';

2) SELECT 'GRANT SELECT ON ALL TABLES IN SCHEMA ' || nspname || ' TO <user name>;'  FROM pg_namespace WHERE nspname not like 'pg%';

3) SELECT 'ALTER DEFAULT PRIVILEGES IN SCHEMA ' || nspname || ' GRANT SELECT ON TABLES TO <user name>;' FROM pg_namespace WHERE nspname not like 'pg%';
Email ThisBlogThis!Share to TwitterShare to FacebookShare to Pinterest





------------------------------------------------------------------
------------------------------------------------------------------  info test
------------------------------------------------------------------
--- u¿ytkownik odczytuj¹cy 
REVOKE all on schema public from u_a;
REVOKE select ON ALL TABLES IN SCHEMA  public from u_a;
DROP ROLE  u_a;
CREATE ROLE u_a
WITH PASSWORD 'w5cgaRR4'
VALID UNTIL 'infinity'
LOGIN INHERIT
;


GRANT all ON SCHEMA public TO u_a;
GRANT select ON ALL TABLES IN SCHEMA  public TO u_a;

-------------------------------------------------------------------
REVOKE all on schema public from u_b;
REVOKE select ON ALL TABLES IN SCHEMA  public from u_b;
DROP ROLE  u_b;
CREATE ROLE u_b
WITH PASSWORD 'w5cgaRR4'
VALID UNTIL 'infinity'
LOGIN INHERIT
;
GRANT all ON SCHEMA public TO u_b;
GRANT select ON ALL TABLES IN SCHEMA  public TO u_b;
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

psql -U postgres  -c "ALTER DEFAULT PRIVILEGES for role  u_b IN SCHEMA public GRANT SELECT ON TABLES TO u_a;"


psql -U u_b -c "drop table if exists A ;"
psql -U u_b -c "create table A (a integer); "
psql -U u_a -c "select * from A;"








psql -U u_b -c "drop table if exists A ;"

# psql -U postgres  -c "ALTER DEFAULT PRIVILEGES IN SCHEMA public revoke SELECT ON TABLES from u_a;"


---- alert dla wszystkich schemate
 psql -U postgres  -c "ALTER DEFAULT PRIVILEGES for role u_b GRANT SELECT ON TABLES TO u_a;" 



------------------------------------------------------------------
------------------------------------------------------------------
------------------------------------------------------------------   utworzeni u¿ytkownika 
------------------------------------------------------------------



--drop owned by read_only;
DROP ROLE  read_only;
CREATE ROLE read_only
WITH PASSWORD 'w5fo4rm5'
VALID UNTIL 'infinity'
LOGIN INHERIT
;

REVOKE ALL ON schema public FROM read_only;
----------------- tworzenie uprawnieñ 
psql -t -f u_read_only_grant.sql  | psql -U postgres

SELECT 'GRANT USAGE ON SCHEMA ' || nspname || ' TO read_only;' FROM pg_namespace WHERE nspname not like 'pg%';
SELECT 'GRANT SELECT ON ALL TABLES IN SCHEMA ' || nspname || ' TO read_only;'  FROM pg_namespace WHERE nspname not like 'pg%';
select 'ALTER DEFAULT PRIVILEGES for role ' ||  usename || ' GRANT SELECT ON TABLES TO read_only;' from pg_user where usename not in ('read_only');

----------------- usuwanie uprawnieñ 

SELECT 'REVOKE all ON SCHEMA ' || nspname || ' FROM read_only;' FROM pg_namespace WHERE nspname not like 'pg%';
SELECT 'REVOKE all ON ALL TABLES IN SCHEMA ' || nspname || ' FROM read_only;'  FROM pg_namespace WHERE nspname not like 'pg%';
select 'ALTER DEFAULT PRIVILEGES for role ' ||  usename || ' REVOKE all on  TABLES FROM read_only;' from pg_user where usename not in ('read_only');

----


------------------ granty
GRANT USAGE ON SCHEMA a TO read_only;  (prawo do u¿ywania)
GRANT SELECT ON ALL TABLES IN SCHEMA a TO read_only;  (prawo do istniej¹cych )

ALTER DEFAULT PRIVILEGES for role akrupa GRANT SELECT ON TABLES TO read_only; (je¿eli u¿ytkownik akrupa coœ utworzy to u¿ytkownik read_only mo¿e czytaæ)
-------------------
