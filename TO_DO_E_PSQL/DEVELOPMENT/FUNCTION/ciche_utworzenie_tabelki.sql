CREATE or replace FUNCTION  loop_query_results() RETURNS void as $$
BEGIN

  EXECUTE 'create table A(a integer );';

END;
$$ LANGUAGE plpgsql;
