SELECT ReferenceID, COUNT(*)
FROM {{ref("fct_sales")}}
GROUP BY ReferenceID
HAVING COUNT(*) > 1