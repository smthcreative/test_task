WITH agent_discount AS (
  SELECT
    `Sales Agents`,
    AVG(`Discount Amount`) AS avg_agent_discount
  FROM
    {{ ref('fct_sales') }}
  GROUP BY
    `Sales Agents`
),
overall_avg_discount AS (
  SELECT
    AVG(`Discount Amount`) AS overall_avg_discount
  FROM
    {{ ref('fct_sales') }}
)

SELECT
  a.`Sales Agents`,
  a.avg_agent_discount
FROM
  agent_discount a,
  overall_avg_discount o
WHERE
  a.avg_agent_discount > o.overall_avg_discount
ORDER BY
  a.avg_agent_discount DESC