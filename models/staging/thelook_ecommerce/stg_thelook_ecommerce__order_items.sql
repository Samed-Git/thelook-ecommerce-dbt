with 

source as (

    select * from {{ source('thelook_ecommerce', 'order_items') }}

),

renamed as (

    select
        -- Primary Key
        id as item_id,

        -- Foreign Keys
        order_id,
        user_id as customer_id,
        product_id,
        inventory_item_id,

        -- Item Attributes
        TRIM(LOWER(status)) as item_status,
        ROUND(sale_price, 2) as item_sale_price,

        -- Timestamps
        CAST(created_at AS TIMESTAMP) as created_at,
        CAST(shipped_at AS TIMESTAMP) as shipped_at,
        CAST(delivered_at AS TIMESTAMP) as delivered_at,
        CAST(returned_at AS TIMESTAMP) as returned_at

    from source

)

select * from renamed