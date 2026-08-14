with 

source as (

    select * from {{ source('thelook_ecommerce', 'products') }}

),

renamed as (

    select
        -- Primary Key
        id as product_id,

        -- Foreign Keys
        distribution_center_id,

        -- Product Attributes
        nullif(trim(name), '') as product_name,
        nullif(trim(category), '') as product_category,
        nullif(trim(brand), '') as product_brand,
        nullif(trim(department), '') as product_department,
        nullif(trim(sku), '') as product_sku,

        -- Financial Attributes
        round(cost, 2) as product_cost,
        round(retail_price, 2) as product_retail_price

    from source

)

select * from renamed