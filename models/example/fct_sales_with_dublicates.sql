WITH base_data AS (
  SELECT 
    `Reference ID` as ReferenceID,
    `Product Name`,
    `Country`,
    `Campaign Name`,
    `Source`,
    COALESCE(`Sales Agent Name`, 'N/A') AS Sales_Agent_Name,
    `Total Amount`,
    `Total Rebill Amount`,
    `Number Of Rebills`,
    `Discount Amount`,
    `Returned Amount`,
    PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Return Date Kyiv`) AS `Return Date Kyiv`,
    DATETIME(TIMESTAMP(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Return Date Kyiv`)), "UTC") AS `Return Date UTC`,
    DATETIME(TIMESTAMP(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Return Date Kyiv`)), "America/New_York") AS `Return Date New York`,
    PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Order Date Kyiv`) AS `Order Date Kyiv`,
    DATETIME(TIMESTAMP(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Order Date Kyiv`)), "UTC") AS `Order Date UTC`,
    DATETIME(TIMESTAMP(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Order Date Kyiv`)), "America/New_York") AS `Order Date New York`,
    DATE_DIFF(DATE(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Return Date Kyiv`)), DATE(PARSE_TIMESTAMP('%B %d, %Y, %I:%M %p', `Order Date Kyiv`)), DAY) AS `Days Between Return And Sale`,
    (`Total Amount` + COALESCE(`Total Rebill Amount`, 0) - COALESCE(`Returned Amount`, 0)) AS `Total Revenue`,
    COALESCE(`Total Rebill Amount`, 0) AS `Rebill Revenue`
  FROM 
    {{ ref('Sample Data for GYB test - Query result') }}
)


SELECT 
  `ReferenceID`,
  `Product Name`,
  `Country`,
  `Campaign Name`,
  `Source`,
  STRING_AGG(Sales_Agent_Name, ', ') AS `Sales Agents`,
  `Total Revenue`,
  `Rebill Revenue`,
  `Number Of Rebills`,
  `Discount Amount`,
  `Returned Amount`,
  `Return Date Kyiv`,
  `Return Date UTC`,
  `Return Date New York`,
  `Days Between Return And Sale`,
  `Order Date Kyiv`,
  `Order Date UTC`,
  `Order Date New York`
FROM 
  base_data
GROUP BY 
  `ReferenceID`,`Product Name`, `Country`, `Campaign Name`, `Source`, `Total Revenue`, `Rebill Revenue`, 
  `Number Of Rebills`, `Discount Amount`, `Returned Amount`, `Return Date Kyiv`, `Return Date UTC`, 
  `Return Date New York`, `Days Between Return And Sale`, `Order Date Kyiv`, `Order Date UTC`, 
  `Order Date New York`


