with 

source as (

    select * from {{ source('raw', 'product') }}

),

renamed as (

    select
        products_id,
        CAST(purchse_price AS float64) AS purchase_price

    from source

)

select * from renamed

