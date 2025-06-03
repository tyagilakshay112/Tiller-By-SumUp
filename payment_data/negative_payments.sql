SELECT 
  dim_type,
  SUM(m_amount) AS total_negative_amount
FROM 
  `tiller-by-sumup-461710.Tiller.payment_data`
WHERE 
  m_amount < 0
GROUP BY 
  dim_type;