

date; pg_dump --table=customer_activity | gzip -9 > customer_activity_dump.gz; date



# tworzy wy³¹cznie dane do za³adowania


pg_dump --data-only  --table=mnp_desc  >   mnp_desc.sql
 reson_code  -- prod
 reason_code -- dev





pg_dump --data-only  --table=DISTRIBUTORS > distributors.sql
pg_dump --data-only  --table=mnp_desc  >   mnp_desc.sql 
pg_dump --data-only  --table=mnp  >   mnp.sql
pg_dump --data-only  --table=products > products.sql
pg_dump --data-only  --table=orders   > orders.sql



TRUNCATE TABLE mnp;
TRUNCATE TABLE mnp_desc;
TRUNCATE TABLE distributors;
TRUNCATE TABLE products;
TRUNCATE TABLE orders;


ALTER TABLE  distributors
    ALTER COLUMN sales_channel drop  not null;

 select count(*) from mnp;
 select count(*) from mnp_desc;
 select count(*) from distributors;
 select count(*) from products;
 select count(*) from orders;


pg_dump  --schema-only --table=mis_stg.stg_paid_orders
