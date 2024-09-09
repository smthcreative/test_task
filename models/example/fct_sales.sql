WITH ranked_sales AS (
  SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY ReferenceID ORDER BY `Order Date Kyiv` DESC) AS row_num
  FROM {{ ref("fct_sales_with_dublicates")}}
)

SELECT *
FROM ranked_sales
WHERE row_num = 1