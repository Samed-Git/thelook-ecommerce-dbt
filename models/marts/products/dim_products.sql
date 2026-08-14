with source as (
    select * from {{ ref('stg_thelook_ecommerce__products') }}
),

rename as (
    select 

        product_id,
        distribution_center_id,
        product_name,
        product_category,
        product_brand,
        product_department,
        product_sku,
        product_cost,
        product_retail_price,

        round(product_retail_price-product_cost,2) as unit_profit,
        round(safe_divide
            (product_retail_price-product_cost,
              product_retail_price)*100,2) 
        as profit_margin_percentage,
        case
            when product_retail_price is null then 'Unknown'
            when product_retail_price < 20 then 'Low Price'
            when product_retail_price between 20 and 100 then 'Mid Price'
            else 'High Price'
        end as price_tier,

        case 
            when product_retail_price is null or product_cost is null then null
            when (product_retail_price - product_cost) > 0 then true
            else false
        end as is_profitable
    from source

)

select * from rename