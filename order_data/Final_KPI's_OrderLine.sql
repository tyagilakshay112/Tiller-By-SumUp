SELECT 
  -- Identifiers
  id_order,
  id_order_line,  
  id_table,
  id_waiter,
  id_device,

  -- Date & Time
  DATE(date_opened) AS order_date,
  DATETIME(date_opened) AS order_datetime,
  EXTRACT(HOUR FROM date_opened) AS hour_of_day,
  DATETIME_DIFF(date_closed, date_opened, MINUTE) AS order_duration_minutes,

  -- Time Slot Bucketing
  CASE
    WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 6 AND 11 THEN 'Breakfast'
    WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 12 AND 16 THEN 'Lunch'
    WHEN EXTRACT(HOUR FROM date_opened) BETWEEN 17 AND 21 THEN 'Dinner'
    ELSE 'Late Night'
  END AS time_slot,

  -- Seasonal Tag
  CASE
    WHEN EXTRACT(MONTH FROM date_opened) BETWEEN 4 AND 10 THEN 'Summer'
    ELSE 'Winter'
  END AS season,

  -- Menu Details
  dim_category_translated,
  dim_category,
  dim_name_translated,
  dim_name,
  dim_unit_measure_display,
  dim_status,

  -- Quantity & Price
  m_quantity,
  m_unit_price,
  m_discount_amount,
  m_tax_percent,
  m_cached_price,
  m_cached_payed,

  -- Derived Financial Metrics
  ROUND(m_unit_price * m_quantity, 2) AS gross_line_value,
  ROUND(m_unit_price * m_quantity - m_discount_amount, 2) AS net_line_value,
  ROUND((m_unit_price * m_quantity) * m_tax_percent / 100, 2) AS tax_amount,

  -- Per Customer Metrics
  m_nb_customer,
  CASE 
    WHEN m_nb_customer > 0 THEN ROUND(m_cached_price / m_nb_customer, 2)
    ELSE NULL
  END AS avg_price_per_customer

FROM `tiller-by-sumup-461710.Tiller.Lakshay_Cleaned_order_data`

WHERE 
  dim_status != 'IN_PROGRESS'
  AND date_opened IS NOT NULL 
  AND date_closed IS NOT NULL