# Big Data Systems

## Design Enterprise Data Lake System for a Medical Data Processing Company

Project: Design a Scalable Data Lake Architecture

## Background


Medical Data Processing Company, based out of San Francisco, specializes in processing various types of EMR (Electronic Medical Records) and provides real-time insights to various medical facilities. These data insights are used by their customers to stay compliant with laws, track patient health metrics, admit discharge records, and bed availability. This service is used by about 8000 individual medical care facilities, including Urgent Care (UC), hospitals, nursing homes, emergency rooms, and critical care units.

The company has experienced hyper growth over the past 3 years. However, as the volume of data continues to grow, the existing infrastructure has not been able to scale. The company has made every type of optimization, configuration changes, and hardware updates, but it has not helped significantly in terms of performance and scale.

Last week, there was a surge in data, during the nightly ETL process, the database server crashed and the whole system was offline for several hours. The CTO has hired you to evaluate if building a Data Lake makes sense to solve the company’s challenges. You are expected to provide a detailed Data Lake design and rationale behind your design decisions.

## Deliverables

This project requires 3 deliverables. 

- The Architecture Diagram with all the components of the Big Data System
- The Architecture Design Document which is targets for technical people
- The Architecture Executive Presentation which is targets non-technical people

# Solution

## Architecture Diagram

![ArchitectureDiagram drawio](https://user-images.githubusercontent.com/30504231/208267368-27787fec-d622-4b8b-a4fc-a8086bb3ff35.png)

## Architecture Design Document

The <a href="https://github.com/danielrsfreitas/data_architect/blob/main/big_data_systems/assets/datalakearchitecturedesign-starter-1.docx">architecture design document</a> is made for technical staff members and contains architectural decision that are part of the system proposal.

Things you can find in this document are:

### Purpose of the new system

The purpose is to provide a deep technical understanding of the new Data Lake proposal for the Medical Data Processing Company. The next few subsections contain the architecture decisions that account for the migration from the current process to the Data Lake solution, as well as all the benefits brought by the new proposal. 

The current solution in place is not able to meet the Medical Data Processing Company needs and requirements and that is why a new proposition is made.

The target audience are technical people, such as engineers, software architects and related.

In scope of the project:
- Ingestion layer
- Storage layer
- Processing layer
= Serving layer

Out of scope of the project:
- Monitoring
- Data quality
- Governance


### Requirements 

**Business**

- Improve uptime of overall system 
- Reduce latency of SQL queries and reports
- System should be reliable and fault tolerant
- Architecture should scale as data volume and velocity increases
- Improve business agility and speed of innovation through automation and ability to experiment with new frameworks
- Embrace open-source tools, avoid proprietary solutions which can lead to vendor lock-in
- Metadata driven design - a set of common scripts should be used to process different types of incoming data sets rather than building custom scripts to process each type of data source. 
- Centrally store all the enterprise data and enable easy access

**Technical**

- Ability to process incoming files on the fly (instead of nightly batch loads today)
- Separate the metadata, data and compute/processing layers
- Ability to keep unlimited historical data
- Ability to scale up processing speed with increase in data volume
- System should sustain small number of individual node failures without any downtime
- Ability to perform change data capture (CDC), UPSERT support on a certain number of tables
- Ability to drive multiple use cases from same dataset, without the need to move the data or extract the data
- Ability to integrate with different ML frameworks such as TensorFlow
- Ability to create dashboards using tools such as PowerBI, Tableau, or Cognos
- Generate daily, weekly, nightly reports using scripts or SQL
- Ad-hoc data analytics, interactive querying capability using SQL


### Current Data Volume

- Data coming from over 8K facilities
- 99% zip files size ranges from 20 KB to 1.5 MB
- Edge cases - some large zip files are as large as 40 MB
- Each zip files when unzipped will provide either CSV, TXT, XML records
- In case of XML zip files, each zip file can contain anywhere from 20-300 individual XML files, each XML file with one record
- Average zip files per day: 77,000
- Average data files per day: 15,000,000
- Average zip files per hour: 3500
- Average data files per hour: 700,000
- Data Volume Growth rate: 15-20% YoY

### Data Lake Architeture Design Principles

1. Embrace open-source technologies under the hood to avoid vendor lock-in.
2. Isolate the layers, such as: ingestion, storage, processing, serving, scheduling and monitoring to enable autonomy in each component.
3. Consider using distributed processing where it makes sense to speed up processing time.
4. Consider using streaming processing where it makes sense to speed up analytics.
5. Consider using tools/technologies that scale horizontally to better scale.
6. Consider using monitoring tool everywhere possible to increase observability.
7. Log every part of the process to enable auditing and traceability.
8. Take snapshots to back up the data.
9. Enable routines of data validation to ensure data quality and good data to the end users.

### Assumptions

1. The ingestion of external sources will be made through FTP servers and API. The idea is to use connectors of the Data Lake to ingest the data. Either directly from the FTP server or from the Kafka broker
2. The Airflow orchestrates any task dependency across the entire data flow.
3. Grafana, the observability tool, is plugged at any component across the platform.
4. Snapshots will be taken on the frequency defined in the technical requirements section.
5. Potential risk of the solution is related to data increase. In case of data increase, as the solution horizontally scalable easier than the current platform.
6. Another risk is a little bit of slowness in the user SQL query when compared to the past solution, since it will have to go through the Athena + Iceberg integration.


## Architecture Executive Presentation

The <a href="https://github.com/danielrsfreitas/data_architect/blob/main/big_data_systems/assets/datalakeexecutivepresentation-starter-1.pptx">architecture executive presentation</a> is made for non-technical, business people.