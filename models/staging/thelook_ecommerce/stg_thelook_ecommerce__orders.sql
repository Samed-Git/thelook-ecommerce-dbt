with 

source as (

    select * from {{ source('thelook_ecommerce', 'orders') }}

),

renamed as (

    select
        -- IDs
        order_id,
        user_id as customer_id,

        -- Attributes
        status as order_status,
        gender as customer_gender,
        num_of_item as number_of_items,

        -- Timestamps
        created_at,
        returned_at,
        shipped_at,
        delivered_at

    from source

)

select * from renamed