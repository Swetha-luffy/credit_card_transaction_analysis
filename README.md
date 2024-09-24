Credit_Card_Transaction_Analysis

This repository contains SQL queries for analyzing credit card transaction data. The queries cover various aspects of transaction analysis, including exploratory analysis, transaction distribution, top N analysis, transaction trends, and advanced queries for specific insights.

Table of Contents
Database
Exploratory Analysis
Transaction Distribution
Top N Analysis
Transaction Trends
Advanced Queries

Database
The queries are designed to work with a database named credit_card_transaction. Make sure to use this database before running the queries:
sqlCopyUSE credit_card_transaction;
Exploratory Analysis
This section includes basic queries to understand the dataset:

Total number of transactions
Total amount of transactions
Average transaction value

Transaction Distribution
Analyze the distribution of transactions based on various factors:

Transactions by city
Transactions by card type
Transactions by expense type
Transactions by gender
Transactions by year

Top N Analysis
Identify top performers in different categories:

Top 5 cities with highest transaction volume
Top 5 card types with highest transaction volume
Top 5 expense types with highest transaction volume

Transaction Trends
Examine transaction patterns over time:

Daily transaction volume and value
Weekly transaction volume and value
Monthly transaction volume and value

Advanced Queries
This section contains more complex queries for specific insights:

Top 5 cities with highest spends and their percentage contribution
Highest spend month for each year and amount spent in that month for each card type
Transaction details for each card type when reaching a cumulative of 1,000,000 total spends
City with lowest percentage spend for gold card type
Highest and lowest expense types for each city
Percentage contribution of spends by females for each expense type
Card and expense type combination with highest month-over-month growth in Jan-2014
City with highest total spend to total number of transactions ratio during weekends
City that took the least number of days to reach its 500th transaction

Usage
To use these queries:

Set up a MySQL database named credit_card_transaction

Import your credit card transaction data into the credit_trans table
Run the queries in your preferred MySQL client

Contributing
Feel free to fork this repository and submit pull requests with improvements or additional queries for credit card transaction analysis.
