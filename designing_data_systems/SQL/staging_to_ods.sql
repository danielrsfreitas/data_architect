use database PROJECT2;

use schema ODS;

use warehouse WAREHOUSE;

-- GEOGRAPHY TABLE

create or replace table "GEOGRAPHY"(
    "geography_id" number identity primary key,
    "address" string,
    "latitude" double,
    "longitude" double,
    "postal_code" string,
    "city" string,
    "state" string
);

insert into "GEOGRAPHY"("address", "latitude", "longitude", "postal_code", "city", "state")
select distinct
    RECORDJSON:address,
    RECORDJSON:latitude,
    RECORDJSON:longitude,
    RECORDJSON:postal_code,
    RECORDJSON:city,
    RECORDJSON:state
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_BUSINESS;

-- BUSINESS TABLE


create or replace table "BUSINESS"(
    "business_id" string primary key,
    "geography_id" number references PROJECT2.ODS."GEOGRAPHY"("geography_id"),
    "name" string,
    "is_open" string,
    "stars" double
);

insert into "BUSINESS"
select distinct
    RECORDJSON:business_id,
    g."geography_id",
    RECORDJSON:name,
    RECORDJSON:is_open,
    RECORDJSON:stars
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_BUSINESS as b
join 
    PROJECT2.ODS."GEOGRAPHY" as g
on
    RECORDJSON:city = g."city" and
    RECORDJSON:address = g."address" and
    RECORDJSON:latitude = g."latitude" and
    RECORDJSON:longitude = g."longitude" and
    RECORDJSON:state = g."state";


-- CHECKIN TABLE

create or replace table "CHECKIN"(
    "business_id" string primary key references PROJECT2.ODS."BUSINESS"("business_id"),
    "date" string

);

insert into "CHECKIN"
select 
    RECORDJSON:business_id,
    RECORDJSON:date
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_CHECKIN;

-- CUSTOMER TABLE

create or replace table "CUSTOMER"(
    "customer_id" string primary key,
    "average_stars" double,
    "fans" number,
    "review_count" number,
    "name" string
);

insert into "CUSTOMER"
select 
    RECORDJSON:user_id,
    RECORDJSON:average_stars,
    RECORDJSON:fans,
    RECORDJSON:review_count,
    RECORDJSON:name
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_USER;

-- COVID TABLE

create or replace table "COVID"(
  "business_id" string primary key references PROJECT2.ODS."BUSINESS"("business_id"),
  "call_action" string,
  "covid_banner" string,
  "grubhub" string,
  "request_a_quote" string,
  "temporary_closed" string,
  "virtual_services" string,
  "delivery_or_takeout" string,
  "highlights" string
);

insert into "COVID"
select 
    RECORDJSON:"Call To Action enabled",
    RECORDJSON:"Covid Banner",
    RECORDJSON:"Grubhub enabled",
    RECORDJSON:"Request a Quote Enabled",
    RECORDJSON:"Temporary Closed Until",
    RECORDJSON:"Virtual Services Offered",
    RECORDJSON:business_id,
    RECORDJSON:"delivery or takeout",
    RECORDJSON:highlights
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_COVID_FEATURES;

create or replace table "REVIEW"(
    "review_id" string primary key,
    "business_id" string references PROJECT2.ODS."BUSINESS"("business_id"),
    "date" date,
    "cool" number,
    "funny" number,
    "stars" double,
    "useful" double,
    "user_id" string references PROJECT2.ODS."CUSTOMER"("customer_id")
);

-- REVIEW TABLE

insert into "REVIEW"
select 
    RECORDJSON:business_id,
    RECORDJSON:date,
    RECORDJSON:review_id,
    RECORDJSON:cool,
    RECORDJSON:funny,
    RECORDJSON:stars,
    RECORDJSON:useful,
    RECORDJSON:user_id
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_REVIEW;

-- TIP TABLE

create or replace table "TIP"(
  "business_id" string primary key references PROJECT2.ODS."BUSINESS"("business_id"),
  "compliment_count" number,
  "date" date,
  "user_id" string references PROJECT2.ODS."CUSTOMER"("customer_id")
);

insert into "TIP"
select 
    RECORDJSON:business_id,
    RECORDJSON:compliment_count,
    RECORDJSON:date,
    RECORDJSON:user_id
from 
    PROJECT2.STAGING.YELP_ACADEMIC_DATASET_TIP;

-- TEMPERATURE TABLE

create or replace table "TEMPERATURE"(
    "date" date primary key,
    "min_temp" double,
    "max_temp" double,
    "normal_min" double,
    "normal_max" double
);

insert into "TEMPERATURE"(
    "date", "min_temp", "max_temp", "normal_min", "normal_max"
)
select 
    "date" date,
    "min" double,
    "max" double,
    "normal_min" double,
    "normal_max" double
from 
    PROJECT2.STAGING."lv_temperature";


-- PRECIPITATION TABLE

create or replace table "PRECIPITATION"(
    "date" date primary key,
    "precipitation" string,
    "precipitation_normal" double
);

insert into "PRECIPITATION"(
    "date", "precipitation", "precipitation_normal"
)
select 
    "date",
    "precipitation",
    "precipitation_normal"
from 
    PROJECT2.STAGING."lv_precipitation";