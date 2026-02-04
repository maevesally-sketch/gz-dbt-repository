SELECT
orders_id
, DATE(date_date) as date_date
, ROUND(Sum(revenue),2) AS revenue
, SUM(quantity) AS quantity
, ROUND(SUM(purchase_cost),2) AS purchase_cost
,ROUND(SUM(margin),2) AS margin
FROM {{ ref('int_sales_margin') }}
GROUP BY orders_id,date_date