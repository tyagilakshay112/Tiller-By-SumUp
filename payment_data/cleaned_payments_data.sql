--Checking for unique columns, checked: UNIQUE
SELECT id_pay, 
COUNT(*) AS nb
FROM `tiller-by-sumup-461710.Tiller.payment_data`
GROUP BY id_pay
HAVING COUNT(*) > 1;

--Checking for unique columns, checked: NOT unique
SELECT id_order, 
COUNT(*) AS nb
FROM `tiller-by-sumup-461710.Tiller.payment_data`
GROUP BY id_order
HAVING COUNT(*) > 1;

--Checking if there are payments not linked to any order
SELECT pd.*
FROM `tiller-by-sumup-461710.Tiller.payment_data` pd
LEFT JOIN `tiller-by-sumup-461710.Tiller.order_data` od
  ON pd.id_order = od.id_order
WHERE od.id_order IS NULL;

--Checking for nulls, checked: there are only nulls in m_cashback, m_credit columns, 1115765 = 0.0 and 14 = 'null' for both columns. Other columns do not contain nulls
SELECT
  COUNTIF(id_pay IS NULL) AS col1_nulls,
  COUNTIF(id_order IS NULL) AS col2_nulls,
  COUNTIF(dim_status IS NULL) AS col3_nulls,
  COUNTIF(dim_type IS NULL) AS col4_nulls,
  COUNTIF(m_amount IS NULL) AS col5_nulls,
  COUNTIF(m_cashback IS NULL) AS col6_nulls,
  COUNTIF(m_credit IS NULL) AS col7_nulls,
  COUNTIF(date_created IS NULL) AS col8_nulls
FROM `tiller-by-sumup-461710.Tiller.payment_data`;

--Checking for multiple payments
SELECT 
  id_order,
  COUNT(*) AS payment_count
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
GROUP BY 
  id_order
HAVING 
  COUNT(*) > 1;

--Check what the extra records are
SELECT id_pay,
  id_order,
  dim_status,
  COUNT(*) AS count
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
GROUP BY 
  id_pay, id_order, dim_status
HAVING 
  COUNT(*) > 1
ORDER BY 
  id_pay;

-- Check all distinct payment statuses: only 1 in the whole table - 'accepted'
SELECT DISTINCT dim_status
FROM `tiller-by-sumup-461710.Tiller.payment_data`

-- Check all distinct payment types: 30 distinct
SELECT DISTINCT LOWER(TRIM(dim_type)) AS cleaned_type
FROM `tiller-by-sumup-461710.Tiller.payment_data`


--Show me restaurant orders (id_order) that have more than one payment marked as completed: no data to display
SELECT 
  id_order,
  COUNT(*) 
FROM `tiller-by-sumup-461710.Tiller.payment_data`
WHERE LOWER(TRIM(dim_status)) = 'COMPLETED'
GROUP BY id_order
HAVING COUNT(*) > 1;

SELECT 
  id_order,
  id_pay,
  m_amount,
  dim_type,
  dim_status,
  date_created
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
WHERE id_order IN (
  SELECT id_order
  FROM `tiller-by-sumup-461710.Tiller.payment_data`
  WHERE LOWER(TRIM(dim_status)) = 'completed'
  GROUP BY id_order
  HAVING COUNT(*) > 1
)
ORDER BY id_order, date_created;

-- How many payments were accepted for each order: all of the orderas are ACCEPTED, only 1 dim_status in the whole table

SELECT 
  id_order,
  COUNT(*) AS payment_count,
  SUM(m_amount) AS total_paid
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
WHERE 
  LOWER(TRIM(dim_status)) = 'accepted'
GROUP BY 
  id_order
HAVING 
  COUNT(*) > 1
ORDER BY 
  total_paid DESC;

--Indicating negative payments
SELECT 
  dim_type,
  SUM(m_amount) AS total_negative_amount
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
WHERE 
  m_amount < 0
GROUP BY 
  dim_type;

SELECT 
  dim_type,
  COUNT(DISTINCT id_order) AS num_negative_orders,
  SUM(m_amount) AS total_negative_amount
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
WHERE 
  m_amount < 0
GROUP BY 
  dim_type;

--Checking outliers in date_created column
SELECT *
FROM `tiller-by-sumup-461710.Tiller.payment_data`
WHERE DATE(date_created) > CURRENT_DATE() OR DATE(date_created) < '2015-01-01';

--Trimming and lowercasing payment types and payment statuses, deleting 2 columns m_cashback and m_credit containing 0.0 or 'null' only

CREATE OR REPLACE TABLE `tiller-by-sumup-461710.Tiller.cleaned_payment_data` AS
SELECT 
  id_pay,
  id_order,
  LOWER(TRIM(dim_type)) AS payment_type,
  LOWER(TRIM(dim_status)) AS payment_status,
  m_amount,
  date_created
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`;