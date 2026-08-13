with 

source as (

    select * from {{ source('thelook_ecommerce', 'order_items') }}

),

renamed as (

    select
        -- primary key
        id as item_id,

        --foreign key
        order_id,
        user_id as customer_id,
        product_id,
        inventory_item_id,

        --item attribute
        status as item_status,
        created_at,
        shipped_at,
        delivered_at,
        returned_at,
        sale_price as item_sale_price

    from source

)

select * from renamed