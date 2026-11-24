create or replace table util_db.public.my_data_types
(
  my_number number
, my_text varchar(10)
, my_bool boolean
, my_float float
, my_date date
, my_timestamp timestamp_tz
, my_variant variant
, my_array array
, my_object object
, my_geography geography
, my_geometry geometry
, my_vector vector(int,16)
);

SHOW WORKSPACES IN DATABASE "USER$vtt311096";

USE ROLE SYSADMIN;
CREATE OR REPLACE DATABASE ZENAS_ATHLEISURE_DB;
DROP SCHEMA PUBLIC;
CREATE OR REPLACE SCHEMA ZENAS_ATHLEISURE_DB.PRODUCTS;

-- create internal stage to store files
CREATE STAGE ZENAS_ATHLEISURE_DB.PRODUCTS.sweatsuits
	DIRECTORY = ( ENABLE = true ) 
	ENCRYPTION = ( TYPE = 'SNOWFLAKE_SSE' ) 
	COMMENT = 'stage to store sweatsuits files';


-- upload the data files from a folder in snowflake workspace to the stage
COPY FILES INTO @ZENAS_ATHLEISURE_DB.PRODUCTS.sweatsuits
FROM 'snow://workspace/USER$.PUBLIC."snowflake-dlkw-badge-4"/versions/head/data/sweatsuits/';

-- create internal stage to store PRODUCT_METADATA
CREATE STAGE ZENAS_ATHLEISURE_DB.PRODUCTS.PRODUCT_METADATA
	DIRECTORY = ( ENABLE = true ) 
	ENCRYPTION = ( TYPE = 'SNOWFLAKE_SSE' ) 
	COMMENT = 'stage to store PRODUCT_METADATA';

-- upload the data files from a folder in snowflake workspace to the stage
COPY FILES INTO @ZENAS_ATHLEISURE_DB.PRODUCTS.PRODUCT_METADATA
FROM 'snow://workspace/USER$.PUBLIC."snowflake-dlkw-badge-4"/versions/head/data/product_metadata/';