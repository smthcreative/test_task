WITH monthly_revenue AS (
  SELECT
    FORMAT_TIMESTAMP('%Y-%m', `` Order Date Kyiv`) AS month,
    SUM(`Total Revenue`) AS total_revenue
  FROM
    {{ ref('fct_sales') }}
  GROUP BY
    month
)

SELECT
  month,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
  ROUND(((total_revenue - LAG(total_revenue) OVER (ORDER BY month)) / LAG(total_revenue) OVER (ORDER BY month)) * 100, 2) AS revenue_growth_percent
FROM
  monthly_revenue
ORDER BY
  month