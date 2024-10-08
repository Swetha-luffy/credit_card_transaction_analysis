# Credit_Card_Transaction_Analysis

This repository contains SQL queries for analyzing credit card transaction data. The queries cover various aspects of transaction analysis, including exploratory analysis, transaction distribution, top N analysis, transaction trends, and advanced queries for specific insights.

# Table of Contents
1.Database

2.Exploratory Analysis

3.Transaction Distribution

4.Top N Analysis

5.Transaction Trends

6.Advanced Queries


# Database
The queries are designed to work with a database named credit_card_transaction. Make sure to use this database before running the queries:

sqlCopyUSE credit_card_transaction;


# Exploratory Analysis
This section includes basic queries to understand the dataset:

1.Total number of transactions

2.Total amount of transactions

3.Average transaction value

4.Transaction Distribution

# Analyze the distribution of transactions based on various factors:

1.Transactions by city

2.Transactions by card type

3.Transactions by expense type

4.Transactions by gender

5.Transactions by year

# Top N Analysis
Identify top performers in different categories:

1.Top 5 cities with highest transaction volume

2.Top 5 card types with highest transaction volume

3.Top 5 expense types with highest transaction volume

# Transaction Trends
Examine transaction patterns over time:

1.Daily transaction volume and value

2.Weekly transaction volume and value

3.Monthly transaction volume and value

# Advanced Queries
This section contains more complex queries for specific insights:

1.Top 5 cities with highest spends and their percentage contribution

2.Highest spend month for each year and amount spent in that month for each card type

3.Transaction details for each card type when reaching a cumulative of 1,000,000 total spends

4.City with lowest percentage spend for gold card type

5.Highest and lowest expense types for each city

6.Percentage contribution of spends by females for each expense type

7.Card and expense type combination with highest month-over-month growth in Jan-2014

8.City with highest total spend to total number of transactions ratio during weekends

9.City that took the least number of days to reach its 500th transaction


Usage
To use these queries:

Set up a MySQL database named credit_card_transaction

Import your credit card transaction data into the credit_trans table
Run the queries in your preferred MySQL client

Contributing
Feel free to fork this repository and submit pull requests with improvements or additional queries for credit card transaction analysis.
