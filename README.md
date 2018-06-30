# CS 327E Elements of Databases - The University of Texas at Austin
Elements of Databases Fall 2017 Coursework, namely PySpark scripts, SQL queries, and analytics graphics. This course primarily focused on the theory and implementation of relational databases with an introduction to big data processing using Apache Spark. The instructions for each assignment are in the folders for the respective assignments.

## Assignment Workflow
Descriptions of the deliverable tasks associated with each assignment are explained below. Further detail can be found in the assignment instructions pdfs in the folder for each assignment. All assignments were split equally with my partner, Peter Yi.

### Prerequisites and Tools
The designated database management system (RDBMS) for this course was PostgreSQL. We used Amazon Web Services (AWS) for data storage and cluster setup and management and PySpark for processing large queries and jobs.

### Lab 1
Execution of table creation (DDL) statements. Execution of basic SQL queries on an IMDB dataset stored in Amazon S3 buckets and analysis of resulting data using Amazon Quicksight. ERD (Entity Relation Diagram) creation for IMDB database schema.

### Lab 2
Creation of a PostgreSQL instance of Amazon RDS. Population of the instance with the IMDB dataset. Query execution on movie rating information. Design of a star schema for movie rating analysis.

### Lab 3
#### Part 1: 
Execution of intermediate-level queries (aggregate queries) and creation of corresponding virtual and/or materialized views of various sections of the IMDB dataset. Amazon Quicksight visualization of the results of these queries. 
#### Part 2: 
Implementation of the star schema designed in Part 1. Aggregate query execution and Amazon Quicksight visualization of meaningful movie rating data from this schema. 

### Final Project
The final project was divided into four milestones. Lab 1, Lab 2, and Lab 3 used exclusively a common IMDB dataset. The final project outlines an ETL process for ingesting data from two other common movie databases: Cinemalytics (a Bollywood equivalent of IMDB) and Movielens (an academia-based movie recommendation website). All .py files are PySpark scripts. 
#### Milestone 1:
Exploration of the Movielens dataset and ingestion into our previously-configured IMDB database. Configuring of an Amazon EMR (Elastic MapReduce) cluster for Spark job processing.
#### Milestone 2:
Further ingestion (ETL) of Movielens data (specifically, tag data).
#### Milestone 3:
Ingestion of online financial box office data into our database. Query optimization using indices.
#### Milestone 4: 
Full ingestion and cleaning of Cinemalytics dataset. Final ERD of complete database with IMDB, Movielens, box office, and Cinemalytics data.
