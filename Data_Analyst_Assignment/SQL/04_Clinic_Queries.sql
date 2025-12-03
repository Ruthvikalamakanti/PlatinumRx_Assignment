-- Q1: Revenue from each sales channel in a given year
SELECT
  sales_channel,
  SUM(amount) AS total_revenue
FROM
  clinic_sales
WHERE
  strftime('%Y', datetime) = '2021'
GROUP BY
  sales_channel;

-- Q2: Top 10 most valuable customers for a given year
SELECT
  uid,
  SUM(amount) AS total_spent
FROM
  clinic_sales
WHERE
  strftime('%Y', datetime) = '2021'
GROUP BY
  uid
ORDER BY
  total_spent DESC
LIMIT
  10;

-- Q3: Month-wise revenue, expense, profit, status for a given year
SELECT
  strftime('%m', cs.datetime) AS MONTH,
  SUM(cs.amount) AS revenue,
  COALESCE(SUM(e.amount), 0) AS expense,
  SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit,
  CASE
    WHEN SUM(cs.amount) - COALESCE(SUM(e.amount), 0) >= 0 THEN 'Profitable'
    ELSE 'Not Profitable'
  END AS STATUS
FROM
  clinic_sales cs
  LEFT JOIN expenses e ON cs.cid = e.cid
  AND strftime('%Y-%m', cs.datetime) = strftime('%Y-%m', e.datetime)
WHERE
  strftime('%Y', cs.datetime) = '2021'
GROUP BY
  MONTH;

-- Q4: Most profitable clinic for each city for a given month
WITH clinic_profit AS (
  SELECT
    c.city,
    cs.cid,
    SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
  FROM
    clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    AND strftime('%Y-%m', cs.datetime) = strftime('%Y-%m', e.datetime)
  WHERE
    strftime('%Y-%m', cs.datetime) = '2021-09'
  GROUP BY
    c.city,
    cs.cid
)
SELECT
  city,
  cid,
  profit
FROM
  (
    SELECT
      *,
      RANK() OVER (
        PARTITION BY city
        ORDER BY
          profit DESC
      ) AS rnk
    FROM
      clinic_profit
  ) t
WHERE
  rnk = 1;

-- Q5: Second least profitable clinic for each state for a given month
WITH clinic_profit AS (
  SELECT
    c.state,
    cs.cid,
    SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
  FROM
    clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e ON cs.cid = e.cid
    AND strftime('%Y-%m', cs.datetime) = strftime('%Y-%m', e.datetime)
  WHERE
    strftime('%Y-%m', cs.datetime) = '2021-09'
  GROUP BY
    c.state,
    cs.cid
)
SELECT
  state,
  cid,
  profit
FROM
  (
    SELECT
      *,
      RANK() OVER (
        PARTITION BY state
        ORDER BY
          profit ASC
      ) AS rnk
    FROM
      clinic_profit
  ) t
WHERE
  rnk = 2;