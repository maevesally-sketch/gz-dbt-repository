WITH purchase_table AS (
    SELECT
    *
    , quantity * purchase_price AS purchase_cost
FROM {{ ref('stg_raw__sales') }}
LEFT JOIN {{ ref('stg_raw__product') }} USING (products_id)
)
SELECT 
*
, IFNULL(revenue,0) - IFNULL(purchase_cost,0) AS margin
FROM purchase_table

