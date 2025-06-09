WITH table1 AS (
  SELECT * 
  FROM `tiller-by-sumup-461710.Tiller.order_data`
),
joined_data AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id_order_line ORDER BY date_opened) AS row_num
  FROM table1 AS t1
  LEFT JOIN `tiller-by-sumup-461710.Tiller.order_line` 
  USING (id_order)
)

SELECT *
FROM joined_data
WHERE row_num = 1