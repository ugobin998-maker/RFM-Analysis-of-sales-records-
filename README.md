# RFM-Analysis-of-Sales-Records-Project
This project performs a Recency, Frequency, Monetary (RFM) analysis using 2025 sales data. The objective is to evaluate customer purchasing behavior and segment customers into meaningful groups to support targeted business strategies.

![image alt](https://github.com/ugobin998-maker/RFM-Analysis-of-sales-records-/blob/9e7c589ccee155950f18946004a6616c5501dfb6/Screenshot%202026-04-16%20112553.png)

## Tools & Technologies
* Google Cloud Platform (BigQuery)
* SQL (CTEs, Window Functions, Aggregations)
* Power BI (for visualization)

## Project Workflow
### 1. Data Import
A new project was created in Google Cloud BigQuery, and raw sales data was imported from a local device.

### 2. Data Consolidation
Monthly sales data (January–December) was combined into a single table using UNION ALL to ensure all records, including duplicates where applicable, were preserved.

### 3. RFM Calculation
Recency, Frequency, and Monetary values were calculated using:

Recency: Days since last purchase (using date functions)
Frequency: Total number of transactions per customer (COUNT)
Monetary: Total revenue per customer (SUM)

### 4. Customer Ranking
A VIEW was created to rank customers based on RFM values using the ROW_NUMBER() window function.

### 5. RFM Scoring
Another VIEW was created to assign scores (i.e., 1–10) for each RFM metric using the NTILE() function, 10 being the best and 1, the worst.

### 6. Final RFM Dataset
A consolidated VIEW was built containing:

Customer details
RFM values (Recency, Frequency, Monetary)
RFM scores (R, F, M)
Total RFM score (R + F + M)
7. Customer Segmentation

A final RFM table was created by assigning customers into segments based on their total RFM score
