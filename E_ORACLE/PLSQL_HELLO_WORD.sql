 Create or replace FUNCTION f_hello_word
 RETURN VARCHAR
 IS
 BEGIN
 return 'funkca Hellow World';
 END;
 /
 
 select f_hello_word() from dual;
---------------------------------------------------------------- anonymous block

BEGIN
DBMS_OUTPUT.put_line('Hello world');
END;
/

DECLARE
   message  varchar2(20):= 'Hello, World!';
BEGIN
   dbms_output.put_line(message);
END;
/
-- View => DBMS output
--  kilkamy plusik  i mamy

-----------------------------------------------------------------
 create or replace procedure p_hello_world 
 as 
 begin
  DBMS_OUTPUT.put_line('Procedura Hello Word');
 end;
 /
 
 execute p_hello_world;
--------------------------------------------------------------- 
create or replace procedure p_hello_word_param(str in varchar, i integer)
as
BEGIN
 --DBMS_OUTPUT.put_line('Param in procedure: ' +str);
 DBMS_OUTPUT.put_line( 'procedure with param: ' ||  str || ' poraz ' || i);
END;
/
execute p_hello_word_param('Hello word', 4);

