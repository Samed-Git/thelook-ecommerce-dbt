with orders as (

    select * from {{ ref('stg_thelook_ecommerce__orders') }}

),

orders_items as (

    select * from {{ ref('stg_thelook_ecommerce__order_items') }}

),

joined as (

    select 
        -- Orders Primary Details
        orders.order_id,
        orders.customer_id,
        orders.order_status,

        -- Aggregated Metrics from Order Items
        count(orders_items.item_id) as total_items_count,
        round(sum(orders_items.item_sale_price),2) as total_order_amount,

        -- Dates & Durations
        orders.created_at,
        orders.shipped_at,
        orders.delivered_at,
        orders.returned_at,
        date_diff(date(orders.shipped_at), date(orders.created_at), day) as shipping_duration_days,
        date_diff(date(orders.delivered_at), date(orders.shipped_at), day) as delivery_duration_days,

        -- Flags
        case 
            when orders.returned_at is not null then true
            else false 
        end as is_returned

    from orders 
    left join orders_items 
        on orders.order_id = orders_items.order_id

    group by
        orders.order_id,
        orders.customer_id,
        orders.order_status,
        orders.created_at,
        orders.shipped_at,
        orders.delivered_at,
        orders.returned_at

)

select * from joined