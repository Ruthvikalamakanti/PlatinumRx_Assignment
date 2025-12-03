-- Q1: Last booked room for every user
SELECT
  b.user_id,
  b.room_no
FROM
  bookings b
WHERE
  b.booking_date = (
    SELECT
      MAX(booking_date)
    FROM
      bookings
    WHERE
      user_id = b.user_id
  );

-- Q2: Booking ID and total billing amount in November 2021
SELECT
  bc.booking_id,
  SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM
  booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
WHERE
  bc.bill_date BETWEEN '2021-11-01'
  AND '2021-11-30 23:59:59'
GROUP BY
  bc.booking_id;

-- Q3: Bill ID and amount of bills in October 2021 with amount > 1000
SELECT
  bc.bill_id,
  SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM
  booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
WHERE
  bc.bill_date BETWEEN '2021-10-01'
  AND '2021-10-31 23:59:59'
GROUP BY
  bc.bill_id
HAVING
  SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4: Most and least ordered item per month in 2021
SELECT
  strftime('%m', bc.bill_date) AS MONTH,
  i.item_name,
  SUM(bc.item_quantity) AS total_ordered
FROM
  booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
WHERE
  strftime('%Y', bc.bill_date) = '2021'
GROUP BY
  MONTH,
  bc.item_id
ORDER BY
  MONTH,
  total_ordered DESC;

-- Q5: Customers with second highest bill per month in 2021
WITH monthly_bills AS (
  SELECT
    b.user_id,
    strftime('%m', bc.bill_date) AS MONTH,
    SUM(bc.item_quantity * i.item_rate) AS total_amount
  FROM
    booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    JOIN bookings b ON bc.booking_id = b.booking_id
  WHERE
    strftime('%Y', bc.bill_date) = '2021'
  GROUP BY
    b.user_id,
    MONTH
)
SELECT
  MONTH,
  user_id,
  total_amount
FROM
  (
    SELECT
      *,
      DENSE_RANK() OVER (
        PARTITION BY MONTH
        ORDER BY
          total_amount DESC
      ) AS rnk
    FROM
      monthly_bills
  ) t
WHERE
  rnk = 2;