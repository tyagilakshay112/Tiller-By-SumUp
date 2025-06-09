--Data enrichment: added 3 new columns payment_hour, revenue_per_hour and table_turnover_minutes for cleaned order_data table

CREATE OR REPLACE TABLE `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` AS
SELECT
  *,
  EXTRACT(HOUR FROM date_opened) AS payment_hour,
  ROUND(m_cached_payed, 2) AS revenue_per_hour,
  ROUND(TIMESTAMP_DIFF(date_closed, date_opened, SECOND) / 60.0, 2) AS table_turnover_minutes
FROM
  `tiller-by-sumup-461710.Tiller.order_data_Kcleaned`
WHERE
  date_opened IS NOT NULL
  AND date_closed IS NOT NULL;