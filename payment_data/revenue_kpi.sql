--Calculating Revenue related KPIs 
--customer_per_head 
SELECT
    ROUND(SUM(od.m_cached_payed) / NULLIF(SUM(od.m_nb_customer), 0), 2) AS customer_spend_per_head,
    sd.dim_currency
FROM
    `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` od
JOIN
    `tiller-by-sumup-461710.Tiller.store_data` sd ON od.id_store = sd.id_store
WHERE
    od.date_closed IS NOT NULL
    AND od.m_cached_payed IS NOT NULL
    AND od.m_cached_payed > 0
    AND od.m_nb_customer IS NOT NULL
    AND od.m_nb_customer > 0
GROUP BY
    sd.dim_currency;

--Average spend per order
SELECT
  ROUND(SUM(pd.m_amount) / COUNT(DISTINCT od.id_order), 2) AS avg_spend_per_order
FROM
  `tiller-by-sumup-461710.Tiller.cleaned_payment_data` pd
JOIN
  `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` od
  ON pd.id_order = od.id_order;


--Calculating Table Turnover Time (avg table turnover duration) for 4151 > how long tables are occupied on average - shorter times usually mean higher efficiency, as tables are freed up for new guests more quickly.

SELECT
  ROUND(AVG(FLOOR(TIMESTAMP_DIFF(od.date_closed, od.date_opened, SECOND) / 60))) AS avg_table_turnover_minutes,
  'minutes' AS unit
FROM
  `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` od
WHERE od.date_opened IS NOT NULL
  AND od.date_closed IS NOT NULL
  AND TIMESTAMP_DIFF(od.date_closed, od.date_opened, SECOND) >= 60;


--Nb of customers served
SELECT SUM(m_nb_customer) AS total_customers
FROM `tiller-by-sumup-461710.Tiller.order_data_Kcleaned`;

--Revenue per day
SELECT
  DATE(pd.date_created) AS payment_date,
  ROUND(SUM(pd.m_amount), 2) AS daily_revenue
FROM
  `tiller-by-sumup-461710.Tiller.cleaned_payment_data` pd
JOIN
  `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` od
ON
  pd.id_order = od.id_order
GROUP BY
  payment_date
ORDER BY
  payment_date;


--Revenue per hour
SELECT
  EXTRACT(DATE FROM pd.date_created) AS payment_date,
  EXTRACT(HOUR FROM pd.date_created) AS payment_hour,
  ROUND(SUM(pd.m_amount), 2) AS hourly_revenue
FROM
  `tiller-by-sumup-461710.Tiller.cleaned_payment_data` pd
JOIN
  `tiller-by-sumup-461710.Tiller.order_data_Kcleaned` od
ON
  pd.id_order = od.id_order
GROUP BY
  payment_date,
  payment_hour
ORDER BY
  payment_date,
  payment_hour;