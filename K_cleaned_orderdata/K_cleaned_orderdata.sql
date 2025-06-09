## NULL VALUES?
SELECT
  COUNTIF(id_order IS NULL) AS null_id_order,
  COUNTIF(id_store IS NULL) AS null_id_store,
  COUNTIF(id_table IS NULL) AS null_id_table,
  COUNTIF(id_waiter IS NULL) AS null_id_waiter,
  COUNTIF(id_device IS NULL) AS null_id_device,
  COUNTIF(dim_source IS NULL) AS null_dim_source,
  COUNTIF(m_cached_payed IS NULL) AS null_cached_payed,
  COUNTIF(m_cached_price IS NULL) AS null_cached_price,
  COUNTIF(m_nb_customer IS NULL) AS null_nb_customer,
  COUNTIF(date_opened IS NULL) AS null_date_opened,
  COUNTIF(date_closed IS NULL) AS null_date_closed
FROM `Tiller.order_data`;

## UNIQUE COLUMNS?
SELECT
  COUNT(DISTINCT id_order) AS unique_orders,
  COUNT(DISTINCT id_store) AS unique_stores,
  COUNT(DISTINCT id_table) AS unique_tables,
  COUNT(DISTINCT id_waiter) AS unique_waiters,
  COUNT(DISTINCT id_device) AS unique_devices,
  COUNT(DISTINCT dim_source) AS unique_sources,
  COUNT(DISTINCT m_cached_payed) AS unique_payed,
  COUNT(DISTINCT m_cached_price) AS unique_price,
  COUNT(DISTINCT m_nb_customer) AS unique_nb_customer,
  COUNT(DISTINCT date_opened) AS unique_date_opened,
  COUNT(DISTINCT date_closed) AS unique_date_closed
FROM `Tiller.order_data`;

## DUPLICATES?
SELECT id_order, COUNT(*) AS count --PK
FROM `Tiller.order_data`
GROUP BY id_order
HAVING COUNT(*) > 1;

## NEGATIVE VALUES IN REVENUE?
SELECT
  COUNTIF(m_cached_price < 0) AS negative_cached_price,
  COUNTIF(m_cached_payed < 0) AS negative_cached_payed
FROM `Tiller.order_data`;
-- how much?
SELECT
  SUM(CASE WHEN m_cached_payed < 0 THEN m_cached_payed ELSE 0 END) AS total_negative_payed,
  SUM(CASE WHEN m_cached_price < 0 THEN m_cached_price ELSE 0 END) AS total_negative_price
FROM `Tiller.order_data`;

## OTHER NEGATIVE/ZERO VALUES
SELECT
  COUNTIF(m_nb_customer <= 0) AS neg_nb_customer
FROM `Tiller.order_data`;
-- removing rows
 CREATE OR REPLACE TABLE `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` AS
SELECT *
FROM `tiller-by-sumup-461710.Tiller.order_data_Kcleaned`
WHERE NOT (date_opened > date_closed AND m_cached_payed = 0);
