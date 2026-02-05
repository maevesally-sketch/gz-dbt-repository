
WITH int_table AS(
    SELECT 
    date_date 
    , COUNT(orders_id) AS total_number_of_transactions
    , ROUND(SUM(revenue),2) AS total_revenue
    , ROUND(SAFE_DIVIDE(SUM(revenue),COUNT(orders_id)),2) AS average_basket
    , ROUND(SUM(operational_margin),2) AS operational_margin
    , ROUND(SUM(shipping_fee),2) AS total_shipping_fees
    , ROUND(SUM(logcost),2) AS total_log_cost
    FROM {{ ref('int_orders_operational') }}
    GROUP BY date_date
),
product_count AS (
    SELECT
    DATE(date_date) AS date_date
    ,COUNT(products_id) AS products_id
    FROM {{ ref('stg_raw__sales') }}
    GROUP BY date_date
)
SELECT 
int.date_date AS date
,int.total_number_of_transactions
, int.total_revenue
, int.average_basket
, int.operational_margin
, int.total_log_cost
, prod.products_id AS total_qty_products_sold
FROM int_table AS int
LEFT JOIN product_count  AS prod
USING(date_date)
