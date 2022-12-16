use database project2;

use schema STAGING;

use warehouse WAREHOUSE;


create or replace file format csvformat type='CSV' compression='auto'
field_delimiter=',' record_delimiter = '\n'  skip_header=1 error_on_column_count_mismatch=true null_if = ('NULL', 'null') empty_field_as_null = true;

create or replace stage csv_stage file_format = csvformat;

create or replace table "lv_precipitation"(
    "date" DATE,
    "precipitation" STRING,
    "precipitation_normal" STRING
);
create or replace table "lv_temperature"(
    "date" DATE,
    "min" DOUBLE,
    "max" DOUBLE,
    "normal_min" DOUBLE,
    "normal_max" DOUBLE
);
