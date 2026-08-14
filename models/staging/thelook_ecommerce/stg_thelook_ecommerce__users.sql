with 

source as (

    select * from {{ source('thelook_ecommerce', 'users') }}

),

renamed as (

    select
        -- Primary Key
        id as customer_id,

        -- Customer Attributes
        nullif(trim(first_name), '') as customer_first_name,
        nullif(trim(last_name), '') as customer_last_name,
        array_to_string([nullif(trim(first_name), ''), nullif(trim(last_name), '')], ' ') as customer_full_name,
        nullif(trim(lower(email)), '') as customer_email,
        age as customer_age,
        nullif(trim(lower(gender)), '') as customer_gender,

        -- Address & Location Info
        nullif(trim(street_address), '') as customer_street_address,
        nullif(trim(cast(postal_code as string)), '') as customer_postal_code,
        nullif(trim(city), '') as customer_city,
        nullif(trim(state), '') as customer_state,
        nullif(trim(country), '') as customer_country,
        latitude as customer_latitude,
        longitude as customer_longitude,
        user_geom as customer_geom,

        -- Marketing & Metadata
        nullif(trim(lower(traffic_source)), '') as customer_traffic_source,

        -- Timestamps
        safe_cast(created_at as timestamp) as created_at

    from source

)

select * from renamed