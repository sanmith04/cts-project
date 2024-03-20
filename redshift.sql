select * from sales_data;
COPY dev.public.sales_data_copy FROM 's3://s3testred/Adidas US Sales Datasets.csv' IAM_ROLE 'arn:aws:iam::064494532886:role/service-role/AmazonRedshift-CommandsAccessRole-20240320T104509' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'ap-south-1';
drop TABLE sales_data;

UPDATE  sales_data
set invoice_date = TO_DATE(invoice_date,'%d-%m-%y');


CREATE TABLE public.sales_data (
    retailer character varying(255) ENCODE lzo,
    retailer_id integer ENCODE az64,
    Invoice_date character varying(255) ENCODE lzo,
    region
        character varying(255) ENCODE lzo,
        state character varying(255) ENCODE lzo,
        city character varying(255) ENCODE lzo,
        product character varying(255) ENCODE lzo,
        price_per_unit numeric(10, 2) ENCODE az64,
        units_sold integer ENCODE az64,
        total_sales numeric(10, 2) ENCODE az64,
        operating_profit numeric(10, 2) ENCODE az64,
        operating_margin numeric(5, 2) ENCODE az64,
        sales_method character varying(255) ENCODE lzo
) DISTSTYLE AUTO;
create table sales_data_backup as 
select * from sales_data;
update sales_data
set invoice_date = TO_DATE(invoice_date, 'dd-mm-yyyy');

select * from sales_data;
