SET search_path TO mis_stg;

DROP FUNCTION impressions_by_stg_partitioning_file_kmap_insert_trigger() cascade;
CREATE OR REPLACE FUNCTION impressions_by_stg_partitioning_file_kmap_insert_trigger() 
RETURNS TRIGGER AS $$ 
BEGIN 
 IF ( NEW.hash = null  ) THEN  
RAISE EXCEPTION 'hash is null.  Something wrong with the impressions_by_hash_file_insert_trigger() function'; 
 ELSIF ( NEW.hash ='0' OR  NEW.hash ='1' ) THEN  
   INSERT INTO stg_file_kmap_1  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='2' OR  NEW.hash ='3' ) THEN  
   INSERT INTO stg_file_kmap_2  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='4' OR  NEW.hash ='5' ) THEN  
   INSERT INTO stg_file_kmap_3  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='6' OR  NEW.hash ='7' ) THEN  
   INSERT INTO stg_file_kmap_4  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='8' OR  NEW.hash ='9' ) THEN  
   INSERT INTO stg_file_kmap_5  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='a' OR  NEW.hash ='b' ) THEN  
   INSERT INTO stg_file_kmap_6  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='c' OR  NEW.hash ='d' ) THEN  
   INSERT INTO stg_file_kmap_7  VALUES (NEW.*); 
 ELSIF ( NEW.hash ='e' OR  NEW.hash ='f' ) THEN  
   INSERT INTO stg_file_kmap_8  VALUES (NEW.*); 
 ELSE 
 RAISE EXCEPTION 'hash out of range.  Something wrong with the impressions_by_hash_insert_trigger() function!';
 END IF; 
   RETURN NULL; 
END; 
$$
LANGUAGE plpgsql; 


DROP TRIGGER   insert_stg_partitioning_file_kmap ON stg_partitioning_file_kmap;
CREATE TRIGGER insert_stg_partitioning_file_kmap 
  BEFORE INSERT ON  stg_partitioning_file_kmap 
  FOR EACH ROW EXECUTE PROCEDURE impressions_by_stg_partitioning_file_kmap_insert_trigger();








