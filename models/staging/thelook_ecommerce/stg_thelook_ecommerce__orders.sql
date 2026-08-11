with 

source as (

    select * from {{ source('thelook_ecommerce', 'orders') }}

),

renamed as (

    select
        -- Primary Key
        order_id,

        -- Foreign Keys
        user_id as customer_id,

        -- Attributes
        status as order_status,
        gender as customer_gender,
        num_of_item as number_of_items,

        -- Timestamps
        cast(created_at as timestamp) as creation_date,
        cast(returned_at as timestamp) as return_date,
        cast(shipped_at as timestamp) as shipping_date,
        cast(delivered_at as timestamp) as delivering_date

    from source

)

select * from renamed