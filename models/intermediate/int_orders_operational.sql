WITH join_ship AS (
    SELECT
    margin.orders_id AS orders_id
    , margin.date_date AS date_date
    , margin.revenue AS revenue
    , margin.quantity AS quantity
    , margin.purchase_cost AS purchase_cost
    ,margin.margin AS margin
    ,ship.shipping_fee AS shipping_fee
    , ship.logcost AS logcost
    , ship.ship_cost AS ship_cost
    FROM {{ ref('int_orders_margin') }} AS margin
    LEFT JOIN {{ ref('stg_raw__ship') }} AS ship USING (orders_id)
)
SELECT 
orders_id
,date_date
,revenue
,quantity
,purchase_cost
,margin
, shipping_fee
, logcost
,ROUND(margin + shipping_fee - logcost - ship_cost,2) AS operational_margin
FROM join_ship

