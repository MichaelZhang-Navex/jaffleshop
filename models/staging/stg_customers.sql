with

source as (

    select * from {{ source('ecom', 'raw_customers') }}

),

renamed as (

    select

        ----------  ids
        id as customer_id,

        ---------- text

        case
            when LEFT(name, 1) = 'A' then UPPER(name)
            else name
        end as customer_name,
        case
            when LEFT(name, 2) = 'Co' then 'CO'
        end as customer_name_co

    from source

)

select * from renamed
where customer_name_co is null
order by customer_name
