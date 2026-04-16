-- Step1: Appending all monthly sales table to one table all together

CREATE OR REPLACE TABLE `rfm1840.sales.sales_2025` AS
SELECT * FROM `rfm1840.sales.2025_01`
UNION ALL SELECT * FROM `rfm1840.sales.2025_02`
UNION ALL SELECT * FROM `rfm1840.sales.2025_03`
UNION ALL SELECT * FROM `rfm1840.sales.2025_04`
UNION ALL SELECT * FROM `rfm1840.sales.2025_05`
UNION ALL SELECT * FROM `rfm1840.sales.2025_06`
UNION ALL SELECT * FROM `rfm1840.sales.2025_07`
UNION ALL SELECT * FROM `rfm1840.sales.2025_08`
UNION ALL SELECT * FROM `rfm1840.sales.2025_09`
UNION ALL SELECT * FROM `rfm1840.sales.2025_10`
UNION ALL SELECT * FROM `rfm1840.sales.2025_11`
UNION ALL SELECT * FROM `rfm1840.sales.2025_12`;


-- Step 2: Calculate recency, frequency, monetary, r, f, m ranks
-- Combine views with CTEs

CREATE OR REPLACE VIEW `rfm1840.sales.rfm_metrics`
AS 
WITH current_date AS(
      SELECT DATE('2026-04-06') 
      AS analysis_date            -- Today's date
),
    rfm AS(
      SELECT CustomerID, 
        MAX(OrderDate) AS last_order_date,
        DATE_DIFF((SELECT analysis_date FROM current_date), MAX(OrderDate), DAY) AS recency,
        COUNT(*) AS frequency,
        SUM(ordervalue) AS monetary
      FROM `rfm1840.sales.sales_2025`
      GROUP BY CustomerID
    )                                 -- Calculating the recency, frequency and monetary values

SELECT
rfm.*,
ROW_NUMBER() OVER(ORDER BY rfm.recency ASC) AS r_rank,
ROW_NUMBER() OVER(ORDER BY rfm.frequency DESC) AS f_rank,
ROW_NUMBER() OVER(ORDER BY rfm.monetary DESC) AS m_rank,
FROM rfm;                             -- Assigning ranks to recency, frequency and monetary values



-- Step 3: Assigning deciles(10=best, 1=worst)

CREATE OR REPLACE VIEW `rfm1840.sales.rfm_scores`
AS
SELECT *,
        NTILE(10) OVER(ORDER BY r_rank DESC) AS r_score, -- Higher recency values are given lower scores
        NTILE(10) OVER(ORDER BY f_rank DESC) AS f_score, -- Higher frequency values are given higher scores
        NTILE(10) OVER(ORDER BY m_rank DESC) AS m_score, -- Higher monetary values are given higher scores
FROM `rfm1840.sales.rfm_metrics`;                        -- Creating a score system(from 1-10) using NTILE() window function


-- Step 4: Calculating the total scores

  CREATE OR REPLACE VIEW `rfm1840.sales.rfm_total_scores`
  AS 
  SELECT 
    customerid,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    (r_score+ f_score+ m_score) AS rfm_score
FROM `rfm1840.sales.rfm_scores`
ORDER BY rfm_score DESC;


-- Step 5: BI ready rfm segments table

CREATE OR REPLACE TABLE `rfm1840.sales.rfm_segments_final_table`
AS
SELECT 
      customerid,
      recency,
      frequency,
      monetary,
      r_score,
      f_score,
      m_score,
      rfm_score,
      CASE
          WHEN rfm_score >= 28 THEN "Champion"
          WHEN rfm_score >= 24 THEN "Loyal VIPs"
          WHEN rfm_score >= 20 THEN "Potential Loyalists"
          WHEN rfm_score >= 16 THEN "Promising"
          WHEN rfm_score >= 12 THEN "Engaged"
          WHEN rfm_score >= 8 THEN "Requires Attention"
          WHEN rfm_score >= 4 THEN "At Risk"
          ELSE "Lost/Inactive"
      END AS rfm_segment
FROM `rfm1840.sales.rfm_total_scores`
ORDER BY rfm_score DESC;











