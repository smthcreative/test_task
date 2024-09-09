SELECT *
FROM {{ ref('fct_sales') }}
WHERE `Total Revenue` < 0