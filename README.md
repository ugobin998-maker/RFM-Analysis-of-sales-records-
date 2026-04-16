# RFM Analysis Project (2025 Sales Data)

## Project Overview
This project performs a Recency, Frequency, and Monetary (RFM) analysis on monthly sales data for the year 2025. The goal is to evaluate customer purchasing behavior and segment customers based on how recently they purchased, how often they buy, and how much they spend.

The insights from this analysis help identify:

High-value customers to prioritize
Loyal and engaged customers to retain
Inactive or at-risk customers to re-engage

![image alt](https://github.com/ugobin998-maker/RFM-Analysis-of-sales-records-/blob/9e7c589ccee155950f18946004a6616c5501dfb6/Screenshot%202026-04-16%20112553.png)

## Data Preparation & Transformation

Data Loading (Google BigQuery)
  * Created a new project: rfm1840
  * Created a dataset: sales
  * Imported all 12 monthly sales tables into BigQuery from a local machine

Data Processing Steps
  * Combined monthly datasets into a single table: sales_2025
  * Calculated:
             Recency (how recently a customer purchased)
             Frequency (how often they purchase)
             Monetary (total spending)
  * Assigned RFM rankings using SQL window functions
  * Developed a scoring system:
    Scores range from 1 (lowest) to 10 (highest)
  * Computed total RFM score by summing individual scores
  * Created final segmentation table: rfm_segments_final
        Customers grouped into segments such as:
            Champions
            Engaged
            Potential Loyalists
            At Risk
            Lost/Inactive

## Dashboard Creation (Power BI)
  * Data Connection
  Connected Power BI to Google BigQuery

  * Visualizations Created
      Customer Table: Displays all customer RFM data
      Column Chart: Number of customers per segment
      KPI Cards:
        Total Customers
        Total Revenue Generated
## Key Insights
  * 287 unique customers generated $17,069 in revenue
  * The "Engaged" segment has the highest number of customers (61)
  * The "Lost/Inactive" segment has the lowest (7 customers)
  * 38 customers are at risk, representing a key opportunity for retention strategies

## Skills & Tools Used
  * Google BigQuery (GCP) for data storage and processing
  * SQL for data transformation and analysis:
      Views
      Common Table Expressions (CTEs)
      Window functions (e.g., ROW_NUMBER(), NTILE)
      CASE statements
  * Power BI for data visualization and dashboard creation

## Key Learnings
  * End-to-end implementation of an RFM analysis pipeline
  * Practical experience with cloud-based data warehousing
  * Efficient use of SQL for analytical transformations
  * Building interactive dashboards from cloud data sources

### Author
Utkarsh Gobin <br>
Aspiring Data Analyst

