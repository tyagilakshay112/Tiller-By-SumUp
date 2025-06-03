SELECT
  date_created
  , ROUND(AVG(m_amount),2) as turnover_avg_day
FROM `tiller-by-sumup-461710.Tiller.payment_data`
GROUP BY
  date_created
  
