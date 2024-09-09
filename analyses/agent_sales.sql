WITH agent_sales AS (
  SELECT
    `Sales Agents`,
    COUNT(`Reference ID`) AS total_sales,
    AVG(`Total Revenue`) AS avg_revenue,
    AVG(`Discount Amount`) AS avg_discount
  FROM
    {{ ref('fct_sales') }}
  GROUP BY
    `Sales Agents`
)

SELECT
  `Sales Agents`,
  total_sales,
  avg_revenue,
  avg_discount,
  RANK() OVER (ORDER BY avg_revenue DESC) AS rank
FROM
  agent_sales
ORDER BY
  rank