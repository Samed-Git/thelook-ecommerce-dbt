with 

source as (

    select * from {{ source('thelook_ecommerce', 'users') }}

),

renamed as (

    select
        -- Primary Key
        id as customer_id,

        -- Customer Attributes
        first_name as customer_first_name,
        last_name as customer_last_name,
        email as customer_email,
        age as customer_age,
        gender as customer_gender,

        -- Address & Location Info
        street_address as customer_street_address,
        postal_code as customer_postal_code,
        city as customer_city,
        state as customer_state,
        country as customer_country,
        latitude as customer_latitude,
        longitude as customer_longitude,
        user_geom as customer_geom,

        -- Marketing & Metadata
        traffic_source,

        -- Timestamps
        created_at

    from source

)

select * from renamed