mis_db=> \d pg_stat_activity
           View "pg_catalog.pg_stat_activity"
      Column      |           Type           | Modifiers
------------------+--------------------------+-----------
 datid            | oid                      |
 datname          | name                     |
 pid              | integer                  |
 usesysid         | oid                      |
 usename          | name                     |
 application_name | text                     |
 client_addr      | inet                     |
 client_hostname  | text                     |
 client_port      | integer                  |
 backend_start    | timestamp with time zone |
 xact_start       | timestamp with time zone |
 query_start      | timestamp with time zone |
 state_change     | timestamp with time zone |
 waiting          | boolean                  |
 state            | text                     |
 query            | text                     |

mis_db=> select * from  pg_stat_activity ;


select 
  pid
, usename
, query_start 
, state_change
, waiting
, state
, query
from pg_stat_activity where usename='mis_etl';
 


-------- podaj¹c pid do ni¿ej wymienionej fukcji zabijamy zapytanie
---SELECT pg_cancel_backend(14183);



