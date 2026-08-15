with orders as (
    select * from {{ ref('stg_thelook_ecommerce__orders') }}
),

orders_items as (
    select * from {{ ref('stg_thelook_ecommerce__order_items') }}
),

joined as (
    select 
        order_id,
        customer_id,
        item_id,
        order_id,
        customer_id,
        product_id,

        count(item_id) as total_items_count,
        sum(item_sale_price) as total_order_amount,

        date_diff(date(shipped_at),date(created_at), DAY) as shipping_duration_days,
        date_diff(date(shipped_at),date(delivered_at), DAY) as delivery_duration_days,

        case 
            when returned_at is not null then true
            else false 
        end as is_returned

        from orders 
        left join orders_item 
        on orders.order_id = orders_items.order_id
        group by
        order_id,
        customer_id,
        item_id,
        order_id,
        customer_id,
        product_id
)

select * from joined