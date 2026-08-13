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
        name as product_name,
        category as product_category,
        brand as product_brand,
        department as product_department,
        sku as product_sku,

        -- Financial Attributes
        cost as product_cost,
        retail_price as product_retail_price

    from source

)

select * from renamed