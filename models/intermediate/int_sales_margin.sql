WITH purchase_table AS (
    SELECT
    *
    , quantity * purchase_price AS purchase_cost
FROM stg_raw__sales
LEFT JOIN stg_raw__product USING (products_id)
)
SELECT 
*
, revenue - purchase_cost AS margin
FROM purchase_table

