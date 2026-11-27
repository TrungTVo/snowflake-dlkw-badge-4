use role SYSADMIN;
list @zenas_athleisure_db.products.product_metadata;

-- view content of all files in a stage
select $1
from @product_metadata;

-- view content of a specific file in a stage
select $1
from @product_metadata/product_coordination_suggestions.txt;

-- create file format 1 (sweatsuit_sizes.txt)
CREATE OR REPLACE FILE FORMAT ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_1
RECORD_DELIMITER = ';'
TRIM_SPACE = true;

-- inspect file content with file format 1 (sweatsuit_sizes.txt)
create view zenas_athleisure_db.products.sweatsuit_sizes as (
    select REPLACE($1, '\r\n') as sizes_available
    from @product_metadata/sweatsuit_sizes.txt
    (file_format => ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_1)
    where sizes_available <> '')
;

-- create file format 2 (swt_product_line.txt)
create or replace file format ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_2
RECORD_DELIMITER = ';'
FIELD_DELIMITER = '|'
TRIM_SPACE = true;

-- inspect file content with file format 2 (swt_product_line.txt)
create view zenas_athleisure_db.products.SWEATBAND_PRODUCT_LINE as (
    select REPLACE($1, '\r\n') as PRODUCT_CODE, $2 as HEADBAND_DESCRIPTION, $3 as WRISTBAND_DESCRIPTION 
    from @product_metadata/swt_product_line.txt
    (file_format => ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_2))
;

-- create file format 3 (correct) product_coordination_suggestions.txt
create or replace file format ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_3
FIELD_DELIMITER = '='
RECORD_DELIMITER = '^'
TRIM_SPACE = true;

-- inspect file content with file format 3 (product_coordination_suggestions.txt)
create view zenas_athleisure_db.products.SWEATBAND_COORDINATION as (
    select $1 as PRODUCT_CODE, $2 as HAS_MATCHING_SWEATSUIT
    from @product_metadata/product_coordination_suggestions.txt
    (file_format => ZENAS_ATHLEISURE_DB.PRODUCTS.zmd_file_format_3))
;