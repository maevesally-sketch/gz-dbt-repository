-- Join the int_campaigns_day model with finance_daysmodel from the previous unit
-- ads margin (ops margin - ads cost)
 {{ config(materialized = 'view' ) }}

WITH ship_day AS (
   SELECT 
    date_date
    ,SUM(purchase_cost) AS purchase_cost
    ,SUM(margin) AS margin
    , SUM(shipping_fee) AS shipping_fee
    ,SUM(ship_cost) AS ship_cost
   FROM {{ ref('int_orders_operational') }}
   GROUP BY date_date
),
int_table AS (
SELECT 
f.date AS date_date
,ROUND(f.average_basket,2) AS average_basket
,f.operational_margin AS operational_margin
,IFNULL(c.ads_cost,0) AS ads_cost
,IFNULL(c.impression,0) AS ads_impression
,IFNULL(c.click,0) AS ads_clicks
,f.total_number_of_transactions AS quantity
,f.total_revenue AS revenue
, IFNULL(o.purchase_cost,0) AS purchase_cost
, f.total_revenue - IFNULL(o.purchase_cost,0) AS margin
, IFNULL(o.shipping_fee,0) AS shipping_fee
,IFNULL(f.total_log_cost,0) AS log_cost
,IFNULL(o.ship_cost,0) AS ship_cost
FROM {{ ref('finance_days') }} AS f
LEFT JOIN {{ ref('int_campaigns_day') }} AS c ON f.date = c.date_date 
LEFT JOIN ship_day AS o ON c.date_date = o.date_date
)
SELECT
date_date
,average_basket
,ROUND(operational_margin - ads_cost,2) AS ads_margin
,operational_margin
,ads_cost
,ads_impression
,ads_clicks
,quantity
,revenue
,purchase_cost
,margin
,shipping_fee
,log_cost
,ship_cost
FROM int_table
ORDER BY date_date DESC