SELECT `Product Name`
FROM {{ ref('fct_sales') }}
WHERE `Return Date Kyiv` < `Order Date Kyiv`

-- select * 
-- from {{ ref('fct_sales') }}
-- where `Product Name` = "Support 12-month plan"