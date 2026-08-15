with source as (
    select * from {{ ref('stg_thelook_ecommerce__users') }}
),

rename as (
    select
        customer_id,
        customer_first_name,
        customer_last_name,
        customer_full_name,
        customer_age,
        case
            when customer_age is null then 'unknown'
            when customer_age<18 then 'under 18'
            when customer_age between 18 and 25 then '18-25'
            when customer_age between 26 and 45 then '26-45'
            when customer_age between 46 and 60 then '46-60'
            else '+60'
        end as age_group,
        customer_gender,
        customer_email,


        customer_street_address,
        customer_postal_code,
        customer_city,
        customer_state,
        customer_country,
        customer_latitude,
        customer_longitude,
        customer_geom,

        customer_traffic_source,
        created_at,
        safe_cast(date_trunc(date(created_at), month) as timestamp) as signup_cohort
    from source
)

select * from rename