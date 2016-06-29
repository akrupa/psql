 CREATE OR REPLACE FUNCTION fib (
     fib_for integer
 ) RETURNS integer AS $$
 BEGIN
     IF fib_for < 2 THEN
         RETURN fib_for;
     END IF;
     RETURN fib(fib_for - 2) + fib(fib_for - 1);
 END;
$$ LANGUAGE plpgsql;

select fib(8);

drop function if exists fib(integer);

----------------------- szybkie

CREATE OR REPLACE FUNCTION fib_fast(
       fib_for integer
   ) RETURNS integer AS $$
   DECLARE
       ret integer := 0;
       nxt integer := 1;
       tmp integer;
   BEGIN
       FOR num IN 1..fib_for LOOP
           tmp := ret;
          ret := nxt;
          nxt := tmp + nxt;
      END LOOP;

     RETURN ret;
  END;
  $$ LANGUAGE plpgsql;

drop function if exists fib_fast(integer);

explain analyze select fib_fast(26);

