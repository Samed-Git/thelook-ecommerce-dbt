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
        nullif(trim(lower(status)), '') as item_status,
        round(sale_price, 2) as item_sale_price,

        -- Timestamps
        safe_cast(created_at as timestamp) as created_at,
        safe_cast(shipped_at as timestamp) as shipped_at,
        safe_cast(delivered_at as timestamp) as delivered_at,
        safe_cast(returned_at as timestamp) as returned_at

    from source

)

select * from renamed