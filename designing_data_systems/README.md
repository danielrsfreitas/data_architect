# Designing Data Systems

## Design a Data Warehouse for Reporting and OLAP

Project: Effect of Weather on Restaurant Reviews

In this project, I had to use three sources of data and build a Data System on <a href="https://www.snowflake.com/en/"> Snowflake</a> to be able to infer _"How the weather effects Restaurant Reviews"_.

## Data Sources

### YELP

- <a href="https://www.yelp.com">YELP</a> dataset

It contains .JSON files with different contents, such as:

1. Business Information (Restaurant, Cafeteria, Fast-food...)
2. Review
3. User
4. Tip
5. Check in


### Covid-19 dataset

- Covid-19 dataset from Yelp on <a href="https://www.kaggle.com/datasets/claudiadodge/yelp-academic-data-set-covid-features?select=yelp_academic_dataset_covid_features.json">Kaggle</a>

### Climate Dataset (GHCN-D)

- Climate datasets from the <a href="https://www.ncei.noaa.gov/products/land-based-station/global-historical-climatology-network-daily"> Global Historical Climatology Network-Daily (GHCN-D)</a>

It contains .CSV files with Temperature and Precipitation from Las Vegas, Nevada.

# Solution

## Architecture

### Architecture Diagram

1. Multiple files from different sources as input
2. Data is ingested into STAGE area where no manipulation is made. The only transformation is flattening the JSON nested data.]
3. Operational Data Store (ODS) to keep every transactional data <a href="https://pt.wikipedia.org/wiki/OLTP">OLTP</a> in a single place where it can be used for enterprise
4. Data Warehouse where the data is organized in star schema and serve for <a href="https://pt.wikipedia.org/wiki/OLAP">OLAP</a> reporting systems

<img width="1080" alt="Data Architecture Diagram" src="https://user-images.githubusercontent.com/30504231/208000813-bfffb033-cc67-4688-a5d4-dad146d05991.png">

## STAGE

To upload the data to the Snowflake I used the snowsql CLI. <a href="https://github.com/danielrsfreitas/data_architect/blob/main/designing_data_systems/Script/upload.sh">Here</a> is the script used to upload the files before moving to STAGE.

It is important to mention the usage of flags `auto_compress=true` and `parallel=4` for big files to allow better performance while uploading.

With the data published to the Snowflake, it is time to move to the STAGE schema.

1. <a href="https://github.com/danielrsfreitas/data_architect/blob/main/designing_data_systems/SQL/json_to_stage.sql">SQL</a>SQL commands to move data from JSON to STAGE.
2. <a href="https://github.com/danielrsfreitas/data_architect/blob/main/designing_data_systems/Script/csv_to_stage.sql">SQL</a>SQL commands to move data from CSV to STAGE.


### Yelp

![Tables Staging](https://user-images.githubusercontent.com/30504231/208002953-00092e34-3ef4-4a2b-a693-80c999a5cb9f.png)

### Climate

![Tables CSV Staging](https://user-images.githubusercontent.com/30504231/208003064-8766eec4-d011-4255-b560-f3bfab111fae.png)

### Data Size comparison

When the data is uploaded to the Snowflake the content is compressed and the overall storage size decreases. Here is a comparison of raw/stage/ods different sizes.

<img width="469" alt="Size Comparison" src="https://user-images.githubusercontent.com/30504231/208003315-a1f2255d-395c-4c99-aedf-fc5e9064fa4a.png">

## Operational Data Store (ODS)

### ER Diagram

<img width="825" alt="ER Diagram" src="https://user-images.githubusercontent.com/30504231/208002868-10f4e0ab-5dea-4547-80a6-8ff6ec867aff.png">

### Stage to ODS

<a href="https://github.com/danielrsfreitas/data_architect/blob/main/designing_data_systems/SQL/staging_to_ods.sql">Queries</a> to move Stage data to ODS applying different sets of filter and creating the relationships between objects.

### Query to integrate ODS data

Sanity query to show that it is possible to integrate different datasets in the ODS environment.

<img width="1435" alt="Integrate ODS Data" src="https://user-images.githubusercontent.com/30504231/208005995-f0f9e59d-3084-4e39-ab21-8ff71a81cff9.png">


## Data Warehouse

### STAR Schema

<img width="774" alt="Star Schema Diagram" src="https://user-images.githubusercontent.com/30504231/208005361-d9c7405b-b179-44bc-81fc-c84f7880d7ee.png">

### ODS to DW

<a href="https://github.com/danielrsfreitas/data_architect/blob/main/designing_data_systems/SQL/ods_to_dw.sql">Queries</a> to move ODS data to DW applying concepts of OLAP and STAR schema, with fact tables and dimension tables.

### Final Query

The ultimate result requires the utilization of Fact and Dimensions relationships and joins to show a final view, where the business analyst can drive insights about the effect of climate, such as precipitation and temperature, on the number of stars given as review for restaurants.

<img width="1398" alt="Final Query" src="https://user-images.githubusercontent.com/30504231/208005393-dd21638c-08bf-47c1-82bd-f2b4c06017a0.png">

