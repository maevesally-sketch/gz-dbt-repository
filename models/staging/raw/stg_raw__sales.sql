with 

source as (

    select * from {{ source('raw', 'sales') }}

),

renamed as (

    select
        CAST(date_date AS timestamp) AS date_date,
        orders_id,
        pdt_id AS products_id,
        revenue,
        quantity

    from source

)

select * from renamed