WITH aggregated_orders AS (
  SELECT
    -- Identifiers
    id_order,
    id_table,
    id_waiter,
    id_device,

    -- Date & Time
    DATE(MIN(date_opened)) AS order_date,
    DATETIME(MIN(date_opened)) AS order_datetime,
    EXTRACT(HOUR FROM MIN(date_opened)) AS hour_of_day,
    ROUND(AVG(DATETIME_DIFF(date_closed, date_opened, MINUTE))) AS order_duration_minutes,

    -- Time Slot Bucketing
    CASE
      WHEN EXTRACT(HOUR FROM MIN(date_opened)) BETWEEN 6 AND 11 THEN 'Breakfast'
      WHEN EXTRACT(HOUR FROM MIN(date_opened)) BETWEEN 12 AND 16 THEN 'Lunch'
      WHEN EXTRACT(HOUR FROM MIN(date_opened)) BETWEEN 17 AND 21 THEN 'Dinner'
      ELSE 'Late Night'
    END AS time_slot,

    -- Seasonal Tag
    CASE
      WHEN EXTRACT(MONTH FROM MIN(date_opened)) BETWEEN 4 AND 10 THEN 'Summer'
      ELSE 'Winter'
    END AS season,

    -- Aggregated Financials
    SUM(m_quantity) AS total_quantity,
    ROUND(SUM(m_unit_price * m_quantity), 2) AS gross_order_value,
    ROUND(SUM(m_unit_price * m_quantity - m_discount_amount), 2) AS net_order_value,
    ROUND(SUM((m_unit_price * m_quantity) * m_tax_percent / 100), 2) AS total_tax_amount,
    ROUND(SUM(m_discount_amount), 2) AS total_discount,
    ROUND(SUM(m_cached_price), 2) AS total_cached_price,
    ROUND(SUM(m_cached_payed), 2) AS total_cached_payed,

    -- Customer Metrics
    SUM(m_nb_customer) AS total_customers,
    ROUND(SUM(m_cached_payed) / NULLIF(SUM(m_nb_customer), 0), 2) AS spend_per_customer

  FROM `tiller-by-sumup-461710.Tiller.Lakshay_Cleaned_order_data`

  WHERE 
    dim_status != 'IN_PROGRESS'
    AND date_opened IS NOT NULL 
    AND date_closed IS NOT NULL

  GROUP BY id_order, id_table, id_waiter, id_device
)

SELECT 
  ao.*,  -- all aggregated fields
  odk.*  -- all fields from the original order_data_Kcleaned table
FROM aggregated_orders ao
LEFT JOIN `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` odk
  ON ao.id_order = odk.id_order
ORDER BY ao.order_date;