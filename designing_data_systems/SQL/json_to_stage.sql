use database project2;

use schema STAGING;

use warehouse WAREHOUSE;

create or replace file format jsonformat type='JSON' strip_outer_array=true;

create or replace stage json_stage file_format = jsonformat;

create or replace table yelp_academic_dataset_business(recordjson variant);
create or replace table yelp_academic_dataset_checkin(recordjson variant);
create or replace table yelp_academic_dataset_covid_features(recordjson variant);
create or replace table yelp_academic_dataset_review(recordjson variant);
create or replace table yelp_academic_dataset_tip(recordjson variant);
create or replace table yelp_academic_dataset_user(recordjson variant);