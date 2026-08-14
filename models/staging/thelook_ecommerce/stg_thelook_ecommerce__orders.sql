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
        nullif(trim(lower(status)), '') as order_status,
        nullif(trim(lower(gender)), '') as customer_gender,
        num_of_item as number_of_items,

        -- Timestamps
        safe_cast(created_at as timestamp) as created_at,
        safe_cast(returned_at as timestamp) as returned_at,
        safe_cast(shipped_at as timestamp) as shipped_at,
        safe_cast(delivered_at as timestamp) as delivered_at

    from source

)

select * from renamed