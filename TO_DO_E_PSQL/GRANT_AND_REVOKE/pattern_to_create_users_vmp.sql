


DROP ROLE  ;
CREATE ROLE zdziubek
WITH PASSWORD 'w5cgaRR4' 
VALID UNTIL 'infinity'
LOGIN INHERIT
;
--ALTER USER akrupa  WITH PASSWORD 'password';
grant mis to zdziubek;


--------------------------------------------------reporting
GRANT USAGE ON SCHEMA reporting TO zdziubek;
GRANT ALL ON ALL TABLES IN SCHEMA reporting TO zdziubek; 


-------------------------------------------------- s_kamil
GRANT ALL ON SCHEMA s_kamil TO zdziubek;
GRANT ALL ON ALL TABLES IN SCHEMA s_kamil TO zdziubek; 

--------------------------------------------------  aggregates

grant usage on schema aggregates to zdziubek;
grant all on schema   aggregates to zdziubek;
GRANT ALL ON ALL TABLES IN SCHEMA  aggregates TO zdziubek;

--------------------------------------------------- mis_stg
grant usage on schema mis_stg to zdziubek;
GRANT select ON ALL TABLES IN SCHEMA  aggregates TO zdziubek;

-------------------------------------------------- romove GRANT


REVOKE usage on shema reporting to akrupa;

revoke  all  on schema reporting from  akrupa;
revoke  all  on schema mis_stg from  akrupa;
revoke  usage  on schema reporting from  akrupa;
revoke  usage  on schema mis_prcss from  akrupa;

REVOKE INSERT, UPDATE ON ALL TABLES IN SCHEMA public FROM reader;
--------------------------------- to remove








