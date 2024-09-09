SELECT *
FROM {{ ref('fct_sales') }}
WHERE `ReferenceID` IS NULL 
   OR `Product Name` IS NULL 
   OR `Total Revenue` IS NULL