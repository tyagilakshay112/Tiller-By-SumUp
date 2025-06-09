--NOTES: not all queries are filtered on the restaurant
## BASIC KPIS
SELECT
  FORMAT('€%.2f', SUM(m_cached_payed)) AS total_revenue, -- REVENUE
  FORMAT('€%.2f', AVG(m_cached_payed)) AS avg_order_value, -- AVG ORDER VALUE
  SUM(m_nb_customer) AS total_customers, -- #CUSTOMERS
  ROUND(SUM(m_cached_payed) / NULLIF(SUM(m_nb_customer), 0), 2) AS revenue_per_customer, -- REVENUE X CUSTOMER
  ROUND(SUM(m_cached_payed) / COUNT(DISTINCT DATE(date_closed)), 2) AS avg_revenue_per_day, -- AVG REVENUE X DAY
  ROUND(COUNT(id_order) / COUNT(DISTINCT DATE(date_closed)), 2) AS avg_orders_per_day -- AVG ORDER X DAY
FROM `tiller-by-sumup-461710.Tiller.order_data_Kcleaned`

## REVENUE X WEEKDAYS
-- add months, days, years
SELECT
  *,
  EXTRACT(YEAR FROM date_closed) AS year,
  FORMAT_DATE('%B', DATE(date_closed)) AS month,
  FORMAT_DATE('%A', DATE(date_closed)) AS weekday
FROM `Tiller.order_data_Kcleaned`
-- KPI weekday revenue
SELECT
  weekday,
  ROUND(SUM(m_cached_payed), 2) AS total_revenue
FROM `Tiller.order_data_Kcleaned`
WHERE id_store = 4151
GROUP BY weekday
ORDER BY
  CASE weekday
    WHEN 'Monday' THEN 1
    WHEN 'Tuesday' THEN 2
    WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4
    WHEN 'Friday' THEN 5
    WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7
  END;

## REVENUE X WAITER
SELECT
  id_waiter,
  ROUND(AVG(m_cached_payed), 2) AS avg_revenue
FROM `tiller-by-sumup-461710.Tiller.order_data_Kcleaned`
WHERE id_store = 4151 AND id_waiter != 0
GROUP BY id_waiter
ORDER BY avg_revenue DESC
LIMIT 10;

## REVENUE X ORDERS -- TOP PAYING ORDERS PARETO
WITH ordered_revenue AS (
  SELECT
    m_cached_payed,
    ROW_NUMBER() OVER (ORDER BY m_cached_payed DESC) AS row_num,
    COUNT(*) OVER () AS total_rows
  FROM `Tiller.order_data_Kcleaned`
  WHERE id_store = 4151
),
top_20pct AS (
  SELECT *
  FROM ordered_revenue
  WHERE row_num <= total_rows * 0.2
)
SELECT
  FORMAT('€%.2f', (SELECT SUM(m_cached_payed) FROM top_20pct)) AS top_20pct_revenue,
  FORMAT('€%.2f', (SELECT SUM(m_cached_payed) FROM ordered_revenue)) AS total_revenue,
  ROUND((SELECT SUM(m_cached_payed) FROM top_20pct) / NULLIF((SELECT SUM(m_cached_payed) FROM ordered_revenue), 0) * 100, 2) AS top_20pct_share
--> RESULTS: The total revenue from the top 20% most expensive orders. The percentage of total revenue that came from the top 20% orders is 63% -- PARETO

-- which order ids contributed to this?
WITH ordered_revenue AS (
  SELECT
    *,
    ROW_NUMBER() OVER (ORDER BY m_cached_payed DESC) AS row_num,
    COUNT(*) OVER () AS total_rows
  FROM `Tiller.order_data_Kcleaned`
  WHERE id_store = 4151
),
top_20pct_orders AS (
  SELECT *
  FROM ordered_revenue
  WHERE row_num <= total_rows * 0.2
)
SELECT
  id_order,
  m_cached_payed,
  date_closed,
  weekday,
  m_nb_customer,
  id_device,
  id_waiter,
  FORMAT('€%.2f', m_cached_payed) AS formatted_revenue
FROM top_20pct_orders
ORDER BY m_cached_payed DESC
-- to find out which orders are 20% top. We could try finding which dishes were ordered, patterns, waiters...
