
DROP VIEW view_all_grants;
CREATE OR REPLACE VIEW view_all_grants AS
SELECT * FROM (
    SELECT
      use.usename as subject,
      nsp.nspname as namespace,
      c.relname, 
      c.relkind,
      pg_authid.rolname as owner,
      c.relacl,
      c.relaclitemuser,
      use.usename = pg_authid.rolname as via_owner,
      case
        when use.usename = pg_authid.rolname then false
        else pg_has_role(use.usename, pg_authid.rolname, 'member')
      end as via_groupowner,
      use.usename = c.relaclitemuser as via_user,
      case 
        when c.relaclitemuser = '' then false -- acl for public role
        when c.relaclitemuser = '!NULL!' then false -- pg_class.relacl was null
        when c.relaclitemuser = use.usename then false -- pg_has_role(x,x) is always true
        else pg_has_role(use.usename, c.relaclitemuser, 'member') -- does recursive lookup
      end as via_group,
      relaclitemuser = '' as via_public
    FROM
      pg_user use 
      cross join (
          SELECT 
            *,
            split_part(relaclitem, '=', 1) as relaclitemuser 
          FROM (
	      SELECT 
		relnamespace,
		relname,
		relkind,
		relowner,
		relacl,
		CASE
		  WHEN relacl is null THEN '!NULL!=' 
		  ELSE unnest(relacl::text[]) 
		END as relaclitem
              FROM 
		pg_class 
	      ) as sub_c
	  ) as c
      left join pg_namespace nsp on (c.relnamespace = nsp.oid)
      left join pg_authid on (c.relowner = pg_authid.oid) -- users and groups
       where use.usename='sbarosiewicz'
    ) as via
WHERE
  via_owner or via_groupowner or via_user or via_group or via_public
ORDER BY
  subject,
  namespace,
  relname
;


CREATE TABLE Persons
(
PersonID int,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255)
); 

