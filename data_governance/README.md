# Data Governance

## Data Governance at SneakerPark

Build up Data Governance assets to help SneakerPark increase it awarness on their data.

## Background

SneakerPark is an imaginary online shoe reseller. It is a marketplace where people can sell and buy shoes, both used and new shoes. Additionally, the seller also has the ability of selling to the highest bidder. 

SneakerPark authenticates the shoes in an intermediary step before shipping them to the users. The SnekerPark's warehouse will evaluate the condition of the shoes and tell if that is on a good condition or not. It will also match the description of the shoe in terms of size, color and so on with what was inputed by the seller. If the shoe does not meet the criteria, it will be returned back to the seller for the shipping cost

Each buyer and seller must have an active account in order to sell, bid, or purchase sneakers using SneakerPark’s website.

The SneakerPark selling system has the responsability to calculate the final price of the shoe taking into account the shipping fees and service fee. After that, everytime a sell is made, the seller will have the purchase price credited into its account.

Currently, SneakerPark only supports sales within the United States.

## Steps

On this project I had to 

1. Create an Enterprise Conceptual Model that provides a holistic view of data in these three systems.
2. Design the draft version of the Enterprise Data Catalog by documenting the metadata in an Excel spreadsheet.
3. Profile the data to identify 3 data quality issues. Create a document that lists each data quality issue, its description, and a suggested remediation strategy for each.
4. Design a data quality dashboard that will report on the issues identified above plus at least 1 more issue that I foresee might occur in the future.
5. Based on what I read about SneakerPark’s systems and business model, sketch out a proposed MDM implementation architecture, and write a detailed explanation of why you chose this specific approach.
6. Define a set of matching rules that will be used by SneakerPark's MDM Hub to match item and customer entities between the company's different systems.
7. Write a paragraph discussing what data governance roles and responsibilities will be necessary to oversee this new Data Management initiative.

# Solution

The solution comes with 2 main assets

1. <a href="https://github.com/danielrsfreitas/data_architect/blob/main/data_governance/assets/sneakerpark_enterprise_data_catalog.xlsx">SneakerPark Enterprise Data Catalog + Data Quality Management</a>
2. <a href="https://github.com/danielrsfreitas/data_architect/blob/main/data_governance/assets/sneakerpark_data_gov_design_doc.pptx">SneakerPark Data Governance Design Document</a>

That contains the:

## Conceptual Data Model

![CDM](https://user-images.githubusercontent.com/30504231/208499042-7d1b9453-10e6-4803-99b5-ba6d6927eb79.png)


## Master Data Management (MDM) architecture 

![MDM](https://user-images.githubusercontent.com/30504231/208499140-6b90e979-0f2a-42e2-8587-ac790211e667.png)


## Data Quality Dashboard Mockup

![Mockup](https://user-images.githubusercontent.com/30504231/208499130-deb643e7-b3d7-493a-832d-b6be1997c0ac.png)


## Governance Roles and responsabilities

### 1. Data Steward

The Data Steward should be responsible for updating the data dictionary business context in the SneakerPark’s Metadata Management in case of either a new addition (tables or columns) as well as business description changes.

This role can be taken by Jessica as she already has business understanding of every part of the organization along with one new hire to join Jessica on this role because she already has another responsibilities. This way, Jessica can divide the workload with a new employee.

### 2. Data Architect

The Data Architect should be responsible for defining the workflow of the Data Quality Management and Metrics, as well as the Master Data Management architecture for the entire system, in order to find an automated and smart way to identify breaches and data quality issues.

This role can be taken by Daniel Freitas as he is a data architect that has a solid experience on building such platforms.

### 3. Data Engineer (ProdOps)
The Data Engineer focused on ProdOps will be responsible for providing IT production support on the Data Quality Management as well as the Master Data Management. Production support is key to keep consistency, accuracy and timeliness of the data. 

SneakerPark can put Jake on that role as he has ownership of IT Support, therefore he already has expertise on handling such situations. However, Jake will have to go through a specialization on data matter to provide high standard support.

